Extension { #name : #TwiLogin }

{ #category : #'*MastodonFeed' }
TwiLogin >> feedAccountName [
	^ self user screenName
]

{ #category : #'*MastodonFeed' }
TwiLogin >> feedLastUpdateFileReference [
	^ FileLocator imageDirectory / ('twitter-', self account screenName, '.update.ston')
]

{ #category : #'*MastodonFeed' }
TwiLogin >> feedStatusFromMastodon: aStatus [
	self halt
]

{ #category : #'*MastodonFeed' }
TwiLogin >> feedTimelineSinceId: anId account: anAccount [
	^ self 
		timelineUser
		username: anAccount username;
		includeRTs: anAccount includeRTs;
		nextSinceId: anId
]
