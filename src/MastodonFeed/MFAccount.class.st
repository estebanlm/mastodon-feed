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
	^ #(
	'pharo-mastodon-feed' 
	'mastodon-feed' 
	'Mastodon-Twitter' 
	'pharo-mastodon' 
	'pharo-twitter')
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

{ #category : #accessing }
MFAccount >> fullAccountName [
	^ self subclassResponsibility
]

{ #category : #testing }
MFAccount >> isCrosspostOrigin: aString [
	^ self crosspostOrigins anySatisfy: [ :each | aString includesSubstring: each ]
]

{ #category : #accessing }
MFAccount >> lastUpdateReference [
	^ FileLocator imageDirectory / self fullAccountName
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
	
	[ 'Updating from {1} to {2}' format: { 
		self fullAccountName. 
		anAccount fullAccountName } ] emitLogInfo.
	
	lastUpdateReference := self lastUpdateReference.
	lastUpdate := MFAccountUpdate fromReference: lastUpdateReference.
	
	statuses := ((self timelineSinceId: lastUpdate id) 
		select: [ :each | each createdAt > lastUpdate date ])
		select: [ :each | self willExportStatus: each ].
	statuses ifEmpty: [ ^ self ].

	statuses reverseDo: [ :each | | status |
		status := toLogin postStatus: (each feedToStatusOf: anAccount).
		status emitLogInfo ].
	[ '{1} status(es) posted.' format: { statuses size } ] emitLogInfo.

	lastUpdate 
		id: statuses first id;
		storeOn: lastUpdateReference
]

{ #category : #testing }
MFAccount >> willExportStatus: aStatus [
	"I'm used to filter status in bases that can't be processed in the timeline query."
	^ true
]
