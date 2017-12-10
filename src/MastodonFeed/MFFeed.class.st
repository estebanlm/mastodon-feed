"
I'm a feed.
I can log to mastodon and twitter to post toots/twits from one side otor the other.

I'm usually read trough a ston file (who configures me). This is an example of my shape: 

Feed { 
	#direction : 'cross-posting',
	#mastodonAccount : Mastodon {
		#server : ''https://mastodon.social'',
		#username : ''username@mail.net'',
		#password : ''shhh''
	}, 
	#twitterAccount : Twitter {
		#consumerKey : 'CONSUMER_KEY',
		#consumerSecret : 'CONSUMER_SECRET',
		#accessToken : 'ACCESS_TOKEN',
		#accessTokenSecret : 'ACCESS_TOKEN_SECREET',
		#username : nil,
		#includeRTs: false
	}
}
"
Class {
	#name : #MFFeed,
	#superclass : #Object,
	#instVars : [
		'direction',
		'mastodonAccount',
		'twitterAccount'
	],
	#category : #MastodonFeed
}

{ #category : #'ston-core' }
MFFeed class >> stonName [
	^ 'Feed'
]

{ #category : #accessing }
MFFeed >> direction [
	"direction can be any of MFFeedDirecion allDirections collect: #name"
	^ direction
]

{ #category : #accessing }
MFFeed >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
MFFeed >> mastodonAccount [
	^ mastodonAccount
]

{ #category : #accessing }
MFFeed >> mastodonAccount: anObject [
	mastodonAccount := anObject
]

{ #category : #accessing }
MFFeed >> twitterAccount [
	^ twitterAccount
]

{ #category : #accessing }
MFFeed >> twitterAccount: anObject [
	twitterAccount := anObject
]

{ #category : #updating }
MFFeed >> update [
	(MFFeedDirection 
		fromString: self direction)
		updateOn: self
]

{ #category : #updating }
MFFeed >> updateMastodonToTwitter [
	| twitterLogin mastodonLogin lastUpdate statuses  |
	
	twitterLogin := self twitterAccount login.
	mastodonLogin := self mastodonAccount login.
	lastUpdate := mastodonLogin lastUpdate.
	
	statuses := mastodonLogin timelineHome
		sinceId: lastUpdate id;
		all.
	statuses ifEmpty: [ ^ self ].
	
	[ 'Updating mastodon account {1}' format: { mastodonLogin account acct  } ] emitLogInfo.
	statuses reverseDo: [ :each | | status |
		status := each asTwitterStatus.
		twitterLogin postStatus: status.
		status emitLogInfo ].
	[ '{1} toot(s) sent to twitter' format: { statuses size } ] emitLogInfo.
	lastUpdate 
		id: statuses first id;
		store
]

{ #category : #updating }
MFFeed >> updateTwitterToMastodon [
	| twitterLogin mastodonLogin lastUpdate statuses  |
	
	twitterLogin := self twitterAccount login.
	mastodonLogin := self mastodonAccount login.
	lastUpdate := twitterLogin lastUpdate.
	
	statuses := twitterLogin timelineUser
		username: self twitterAccount username;
		includeRTs: self twitterAccount includeRTs;
		sinceId: lastUpdate id;
		all.
	statuses ifEmpty: [ ^ self ].

	[ 'Updating twitter account {1}' format: { twitterLogin user screenName } ] emitLogInfo.	
	statuses do: [ :each | | status |
		status := each asMastodonStatus.
		mastodonLogin postStatus: each asMastodonStatus.
		status emitLogInfo ].
	[ '{1} twit(s) sent to mastodon' format: { statuses size } ] emitLogInfo.

	lastUpdate 
		id: statuses first id;
		store
]
