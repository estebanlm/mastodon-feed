Extension { #name : #MdnLogin }

{ #category : #'*MastodonFeed' }
MdnLogin >> feedLastUpdateFileReference [
	^ FileLocator imageDirectory / 'mastodon-', self account acct, '.update.ston'
]

{ #category : #'*MastodonFeed' }
MdnLogin >> feedStatusFromTwitter: aTwitterStatus [
	| content media |
	
	content := aTwitterStatus fullText.
	aTwitterStatus media ifNotNil: [ 
		
		 ].
	
	^ MdnPostStatus new
		status: content;
		yourself
]
