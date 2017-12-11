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
