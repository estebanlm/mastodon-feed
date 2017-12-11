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
	self mastodonAccount updateTo: self twitterAccount
]

{ #category : #updating }
MFFeed >> updateTwitterToMastodon [
	self twitterAccount updateTo: self mastodonAccount
]
