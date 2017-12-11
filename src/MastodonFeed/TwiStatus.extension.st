Extension { #name : #TwiStatus }

{ #category : #'*MastodonFeed' }
TwiStatus >> feedToStatusOf: anAccount [
	^ anAccount convertToMastodon: self
]
