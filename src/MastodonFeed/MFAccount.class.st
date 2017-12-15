"
I'm an abstract feed account.

I can updateTo: anotherAccount, which means I will transfer my statuses from one account to another.
"
Class {
	#name : #MFAccount,
	#superclass : #Object,
	#instVars : [
		'login'
	],
	#category : #MastodonFeed
}

{ #category : #accessing }
MFAccount class >> crosspostOrigins [
	^ #('pharo-mastodon-feed' 'Mastodon-Twitter')
]

{ #category : #accessing }
MFAccount class >> mastodonApplicationName [
	^ self crosspostOrigins first
]

{ #category : #'ston-core' }
MFAccount class >> stonAllInstVarNames [
	^ super stonAllInstVarNames copyWithout: 'login'
]

{ #category : #accessing }
MFAccount >> account [ 
	^ self login account
]

{ #category : #accessing }
MFAccount >> accountName [
	^ self subclassResponsibility
]

{ #category : #private }
MFAccount >> crosspostOrigins [
	^ self class crosspostOrigins
]

{ #category : #testing }
MFAccount >> isCrosspostOrigin: aString [
	^ self crosspostOrigins anySatisfy: [ :each | aString includesSubstring: each ]
]

{ #category : #accessing }
MFAccount >> lastUpdateReference [
	^ self subclassResponsibility
]

{ #category : #accessing }
MFAccount >> login [
	^ login ifNil: [ login := self newLogin ]
]

{ #category : #'private factory' }
MFAccount >> newLogin [
	^ self subclassResponsibility
]

{ #category : #private }
MFAccount >> timelineSinceId: anId [
	self subclassResponsibility
		
]

{ #category : #updating }
MFAccount >> updateTo: anAccount [
	| lastUpdateReference lastUpdate statuses fromLogin toLogin |
	
	fromLogin := self login.
	toLogin := anAccount login.
	
	lastUpdateReference := self lastUpdateReference.
	lastUpdate := MFAccountUpdate fromReference: lastUpdateReference.
	
	statuses := ((self timelineSinceId: lastUpdate id) 
		reject: [ :each | self isCrosspostOrigin: each source ])
		select: [ :each | each createdAt > lastUpdate date ].
	statuses ifEmpty: [ ^ self ].

	[ 'Updating account {1}' format: { self accountName } ] emitLogInfo.	
	statuses reverseDo: [ :each | | status |
		status := each feedToStatusOf: anAccount.
		toLogin postStatus: status.
		status emitLogInfo ].
	[ '{1} status(es) posted.' format: { statuses size } ] emitLogInfo.

	lastUpdate 
		id: statuses first id;
		storeOn: lastUpdateReference
]
