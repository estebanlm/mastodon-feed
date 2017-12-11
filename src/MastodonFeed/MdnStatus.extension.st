Extension { #name : #MdnStatus }

{ #category : #'*MastodonFeed' }
MdnStatus >> feedToStatusOf: anAccount [
	^ anAccount convertToTwitter: self
]
