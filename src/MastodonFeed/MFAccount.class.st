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

{ #category : #'ston-core' }
MFAccount class >> stonAllInstVarNames [
	^ super stonAllInstVarNames copyWithout: 'login'
]

{ #category : #accessing }
MFAccount >> account [ 
	^ self login account
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

{ #category : #updating }
MFAccount >> updateTo: anAccount [
	| lastUpdateReference lastUpdate statuses fromLogin toLogin |
	
	fromLogin := self login.
	toLogin := anAccount login.
	
	lastUpdateReference := fromLogin feedLastUpdateFileReference.
	lastUpdate := MFAccountUpdate fromReference: lastUpdateReference.
	
	statuses := (fromLogin 
			feedTimelineSinceId: lastUpdate id 
			account: self) 
		select: [ :each | each createdAt > lastUpdate date ].
	statuses ifEmpty: [ ^ self ].

	[ 'Updating twitter account {1}' format: { fromLogin feedAccountName } ] emitLogInfo.	
	statuses do: [ :each | | status |
		status := each feedToStatusOf: toLogin.
		toLogin postStatus: status.
		status emitLogInfo ].
	[ '{1} twit(s) sent to mastodon' format: { statuses size } ] emitLogInfo.

	lastUpdate 
		id: statuses first id;
		storeOn: lastUpdateReference
]
