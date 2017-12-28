Extension { #name : #TwiStatus }

{ #category : #'*MastodonFeed' }
TwiStatus >> feedToStatusOf: anAccount [
	^ anAccount convertToMastodon: self
]

{ #category : #'*MastodonFeed' }
TwiStatus >> fullTextWithDecorations [
	self retweetedStatus 
		ifNotNil: [ :status | ^ status fullTextWithRT ].
	
	^ self fullText
]

{ #category : #'*MastodonFeed' }
TwiStatus >> fullTextWithRT [
	^ String streamContents: [ :stream | 
			stream << 'RT @' << self userName << ' ' << self fullText ]
]

{ #category : #'*MastodonFeed' }
TwiStatus >> loggerString [
	^ '{1} at: {2}' format: { 
		self userName. 
		self createdAt }
]
