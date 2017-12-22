Extension { #name : #MdnStatus }

{ #category : #'*MastodonFeed' }
MdnStatus >> feedToStatusOf: anAccount [
	^ anAccount convertToTwitter: self
]

{ #category : #'*MastodonFeed' }
MdnStatus >> loggerString [
	^ '{1} at: {2}' format: { 
		self accountName. 
		self createdAt }
]

{ #category : #'*MastodonFeed' }
MdnStatus >> strippedContent [
	^ self 
		jsonAt: 'mfStrippedContent' 
		ifAbsentPut: [ 
			MFRemoveHTMLVisitor new
				in: [ :this | (XMLHTMLParser parse: self content) acceptNodeVisitor: this ];
				contents ]
]
