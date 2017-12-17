Class {
	#name : #MFRemoveHTMLVisitor,
	#superclass : #XMLNodeVisitor,
	#instVars : [
		'stream'
	],
	#category : #MastodonFeed
}

{ #category : #accessing }
MFRemoveHTMLVisitor >> contents [ 
	^ stream contents
]

{ #category : #initialization }
MFRemoveHTMLVisitor >> initialize [
	super initialize.
	stream := String new writeStream
]

{ #category : #visiting }
MFRemoveHTMLVisitor >> visitAnchorElement: anElement [
	anElement nodes isEmptyOrNil 
		ifTrue: [ 
			stream << (anElement attributeAt: #href) ]
		ifFalse: [ 
			super visitElement: anElement.
			stream << ' (' << (anElement attributeAt: #href) << ')' ]
]

{ #category : #visiting }
MFRemoveHTMLVisitor >> visitElement: anElement [
	"(anElement name = 'a') ifTrue: [ ^ self visitAnchorElement: anElement ]."
	^ super visitElement: anElement
]

{ #category : #visiting }
MFRemoveHTMLVisitor >> visitStringNode: aStringNode [
	stream << aStringNode string
]
