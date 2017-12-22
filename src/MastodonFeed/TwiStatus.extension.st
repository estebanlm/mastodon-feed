Extension { #name : #TwiStatus }

{ #category : #'*MastodonFeed' }
TwiStatus >> feedToStatusOf: anAccount [
	^ anAccount convertToMastodon: self
]

{ #category : #'*MastodonFeed' }
TwiStatus >> loggerString [
	^ '{1} at: {2}' format: { 
		self account screenName. 
		self createdAt }
]
