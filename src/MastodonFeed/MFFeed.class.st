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
		
	statuses reverseDo: [ :each | twitterLogin postStatus: each asTwitterStatus ].
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
		
	statuses do: [ :each | mastodonLogin postStatus: each asMastodonStatus ].
	lastUpdate 
		id: statuses first id;
		store
]
