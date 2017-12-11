"
I keep information of last account update.
"
Class {
	#name : #MFAccountUpdate,
	#superclass : #Object,
	#instVars : [
		'date',
		'id'
	],
	#category : #MastodonFeed
}

{ #category : #'instance creation' }
MFAccountUpdate class >> fromReference: aReference [
	aReference exists 
		ifFalse: [ ^ self new storeOn: aReference ].
	^ aReference readStreamDo: [ :stream | STON fromStream: stream ]
]

{ #category : #'ston-core' }
MFAccountUpdate class >> stonName [
	^ 'AccountUpdate'
]

{ #category : #accessing }
MFAccountUpdate >> date [
	^ date
]

{ #category : #accessing }
MFAccountUpdate >> date: anObject [
	date := anObject
]

{ #category : #accessing }
MFAccountUpdate >> id [
	^ id
]

{ #category : #accessing }
MFAccountUpdate >> id: anObject [
	id := anObject
]

{ #category : #printing }
MFAccountUpdate >> storeOn: aFileReference [
	date := DateAndTime now.
	aFileReference 
		ensureDelete;
		writeStreamDo: [ :stream |  
			(STONWriter on: stream)
				prettyPrint: true;
				newLine: OSPlatform current lineEnding; 
				nextPut: self ]
]
