Extension { #name : #String }

{ #category : #'*MastodonFeed' }
String >> allMentions [
	| start word words |
	
	words := OrderedCollection new.
	start := 1.
	[ start < self size ]
	whileTrue: [ 
		start := self indexOf: $@ startingAt: start ifAbsent: [ self size + 1 ].
		start < self size ifTrue: [ 
			word := self 
				copyFrom: start 
				to: (self 
					indexOfAnyOf: ' ;:,'  
					startingAt: start + 1
					ifAbsent: [ self size + 1 ]) - 1.
			start := start + word size.
			words add: word trimBoth ] ].
	^ words asArray
]

{ #category : #'*MastodonFeed' }
String >> splitFullWordsWithLimit: aNumber [	
	^ Array streamContents: [ :stream | | string readStream |
		string := ''.
		readStream := self readStream.
		[ readStream atEnd ]
		whileFalse: [ | word |
			word := readStream upTo: Character space.
			((string size + word size) <= 275)
				ifTrue: [ string := string, ' ', word ]
				ifFalse: [ stream add: string. string := word ] ].
		stream add: string ]
]
