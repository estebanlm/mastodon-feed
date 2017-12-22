"
I'm a twitter account. 
I keep server, username and password.
I can connect with twitter.

In general, I'm used to keep a twitter configuration into a ston file. The file will have this shape: 

Twitter {
	#consumerKey : ''CONSUMEE_KEY'',
	#consumerSecret : ''CONSUME_SECRET'',
	#accessToken : ''ACCESS_TOKEN'',
	#accessTokenSecret :  ''ACCESS_TOKEN_SECRET'',
	#username : nil,
	#includeRTs: false
}
"
Class {
	#name : #MFTwitterAccount,
	#superclass : #MFAccount,
	#instVars : [
		'consumerKey',
		'consumerSecret',
		'accessToken',
		'accessTokenSecret',
		'username',
		'includeRTs',
		'includeReplies'
	],
	#category : #MastodonFeed
}

{ #category : #accessing }
MFTwitterAccount class >> defaultIncludeRTs [
	^ false
]

{ #category : #'ston-core' }
MFTwitterAccount class >> stonName [
	^ 'Twitter'
]

{ #category : #'accessing api' }
MFTwitterAccount >> accessToken [
	^ accessToken
]

{ #category : #'accessing api' }
MFTwitterAccount >> accessToken: anObject [
	accessToken := anObject
]

{ #category : #'accessing api' }
MFTwitterAccount >> accessTokenSecret [
	^ accessTokenSecret
]

{ #category : #'accessing api' }
MFTwitterAccount >> accessTokenSecret: anObject [
	accessTokenSecret := anObject
]

{ #category : #accessing }
MFTwitterAccount >> accountName [
	^ self account screenName
]

{ #category : #'accessing api' }
MFTwitterAccount >> consumerKey [
	^ consumerKey
]

{ #category : #'accessing api' }
MFTwitterAccount >> consumerKey: anObject [
	consumerKey := anObject
]

{ #category : #'accessing api' }
MFTwitterAccount >> consumerSecret [
	^ consumerSecret
]

{ #category : #'accessing api' }
MFTwitterAccount >> consumerSecret: anObject [
	consumerSecret := anObject
]

{ #category : #converting }
MFTwitterAccount >> convertToTwitter: aStatus [
	| post content |
	content := aStatus strippedContent.
	post := TwiPostStatus new.
	post possiblySensitive: aStatus spoilerText isEmptyOrNil not.
	aStatus mediaAttachments collect: [ :each | | tempRef response |
		"remove media link from status"
		content := content copyReplaceAll: each textUrl with: ''. 
		"download media file"
		tempRef := FileReference newTempFilePrefix: 'media-' suffix: '.dat'.
		response := ZnClient new 
			url: each url asZnUrl;
			downloadTo: tempRef;
			response.
		
		post addMedia: (TwiPostMedia 
			fileName: each url asZnUrl lastPathSegment
			reference: tempRef) ].
	
	post content: content.
	
	^ post 
]

{ #category : #accessing }
MFTwitterAccount >> fullAccountName [
	^ self accountName, '@twitter.com'
]

{ #category : #'accessing api' }
MFTwitterAccount >> includeRTs [
	"OPTIONAL: indicates if the query needs to include retwits (default: false)"
	^ includeRTs ifNil: [ includeRTs := self class defaultIncludeRTs ]
]

{ #category : #'accessing api' }
MFTwitterAccount >> includeRTs: anObject [
	includeRTs := anObject
]

{ #category : #accessing }
MFTwitterAccount >> includeReplies [
	^ includeReplies
]

{ #category : #accessing }
MFTwitterAccount >> includeReplies: anObject [
	includeReplies := anObject
]

{ #category : #accessing }
MFTwitterAccount >> lastUpdateReference [
	^ FileLocator imageDirectory / ('twitter-', self accountName, '.update.ston')
]

{ #category : #'private factory' }
MFTwitterAccount >> newLogin [
	^ (TwiLogin 
		consumerKey: self consumerKey
		consumerSecret: self consumerSecret
		accessToken: self accessToken
		accessTokenSecret: self accessTokenSecret)
	account; "ensure credentials verification"
	yourself
		
]

{ #category : #private }
MFTwitterAccount >> timelineSinceId: anId [
	^ self login timelineUser 
		username: self username;
		includeRTs: self includeRTs;
		excludeReplies: self includeReplies not;
		nextSinceId: anId
]

{ #category : #'accessing api' }
MFTwitterAccount >> username [
	"OPTIONAL: the username timeline to query. When I'm 'sniffing' an user account is not mine, 
	 I need to take the twites by querying their public timeline."
	^ username
]

{ #category : #'accessing api' }
MFTwitterAccount >> username: anObject [
	username := anObject
]

{ #category : #testing }
MFTwitterAccount >> willExportStatus: aStatus [
	^ (self isCrosspostOrigin: aStatus source) not
]
