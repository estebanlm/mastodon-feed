"
I'm an abstract class to define the cross-post ""direction"". 
My children have concrete definitions.

I'm used to implement a double dispatch over MFFeed.
"
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
	^ MFFeedDirectionCrossPosting uniqueInstance
]

{ #category : #'instance creation' }
MFFeedDirection class >> fromString: aString [
	^ self allDirections 
		detect: [ :each | each label = aString ]
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

{ #category : #'ston-core' }
MFFeedDirection class >> stonName [
	^ 'FeedDirection'
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

{ #category : #accessing }
MFFeedDirection >> label [ 
	^ self class label
]

{ #category : #printing }
MFFeedDirection >> printOn: stream [ 
	stream << self label
]

{ #category : #'ston persistence' }
MFFeedDirection >> stonOn: stonWriter [
	stonWriter 
		writeObject: self 
		listSingleton: self label
]

{ #category : #updating }
MFFeedDirection >> updateOn: aFeed [
	self subclassResponsibility
]
