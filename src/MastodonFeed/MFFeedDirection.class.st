Class {
	#name : #MFFeedDirection,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #MastodonFeed
}

{ #category : #accessing }
MFFeedDirection class >> allDirections [
	^ self allSubclasses collect: #uniqueInstance
]

{ #category : #accessing }
MFFeedDirection class >> crossPost [
	^ MFFeedDirectionCrossPost uniqueInstance
]

{ #category : #accessing }
MFFeedDirection class >> label [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
MFFeedDirection class >> mastodonToTwitter [
	^ MFFeedDirectionMastodonToTwitter uniqueInstance
]

{ #category : #'instance creation' }
MFFeedDirection class >> new [ 
	^ self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
MFFeedDirection class >> twitterToMastodon [
	^ MFFeedDirectionTwitterToMastodon uniqueInstance
]

{ #category : #'instance creation' }
MFFeedDirection class >> uniqueInstance [
	self = MFFeedDirection 
		ifTrue: [ self error: 'I''m an abstract class. Use one of my children instead.' ]. 
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]
