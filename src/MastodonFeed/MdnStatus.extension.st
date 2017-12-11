Extension { #name : #MdnStatus }

{ #category : #'*MastodonFeed' }
MdnStatus >> feedToStatusOf: aLogin [
	^ aLogin feedStatusFromMastodon: self
]
