Extension { #name : #TwiStatus }

{ #category : #'*MastodonFeed' }
TwiStatus >> feedToStatusOf: aLogin [
	^ aLogin feedStatusFromTwitter: self
]
