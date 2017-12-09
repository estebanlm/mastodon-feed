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
