"
I'm a mastodon account. 
I keep server, username and password.

I can connect with a mastodon instance.
"
Class {
	#name : #MFMastodonAccount,
	#superclass : #MFAccount,
	#instVars : [
		'server',
		'username',
		'password',
		'includeBoosts',
		'includeReplies'
	],
	#category : #MastodonFeed
}

{ #category : #'ston-core' }
MFMastodonAccount class >> stonName [
	^ 'Mastodon'
]

{ #category : #accessing }
MFMastodonAccount >> accountName [
	^ self account acct
]

{ #category : #converting }
MFMastodonAccount >> convertToMastodon: aStatus [
	| content medias |
	
	content := aStatus retweetedStatus
		ifNotNil: [ :rs| rs fullText ]
		ifNil: [ aStatus fullText ].
	"change all names with @name@twitter.com, to show procedence"
	content allMentions do: [ :each | 
		content := content copyReplaceAll: each with: each, '@twitter.com' ].
	"unshorten urls"
	aStatus urls do: [ :each |
		content := content copyReplaceAll: each url with: each expandedUrl ].
	"extract medias"
	medias := aStatus media collect: [ :each | | tempRef response |
		"remove the t.co link to the media"
		content := content copyReplaceAll: each url with: ''.
		"download media file"
		tempRef := FileReference newTempFilePrefix: 'media-' suffix: '.dat'.
		response := ZnClient new 
			url: each mediaUrl asZnUrl;
			downloadTo: tempRef;
			response.
		
		MdnPostMedia new 
			reference: tempRef;
			fileName: each mediaUrl asZnUrl lastPathSegment;
			yourself ].
	
	^ MdnPostStatus new
		content: content;
		medias: medias;
		yourself
]

{ #category : #accessing }
MFMastodonAccount >> fullAccountName [
	^ self accountName, '@', self server asZnUrl host
]

{ #category : #'accessing api' }
MFMastodonAccount >> includeBoosts [
	^ includeBoosts
]

{ #category : #'accessing api' }
MFMastodonAccount >> includeBoosts: anObject [
	includeBoosts := anObject
]

{ #category : #'accessing api' }
MFMastodonAccount >> includeReplies [
	^ includeReplies
]

{ #category : #'accessing api' }
MFMastodonAccount >> includeReplies: anObject [
	includeReplies := anObject
]

{ #category : #initialization }
MFMastodonAccount >> initialize [
	super initialize.
	self includeBoosts: true.
	self includeReplies: false
]

{ #category : #accessing }
MFMastodonAccount >> lastUpdateReference [
	^ FileLocator imageDirectory / ('mastodon-', self accountName, '.update.ston')
]

{ #category : #'private factory' }
MFMastodonAccount >> newLogin [
	^ (MdnServer url: self server)
		applicationName: self class mastodonApplicationName;
		loginUsername: self username password: self password
]

{ #category : #'accessing api' }
MFMastodonAccount >> password [
	^ password
]

{ #category : #'accessing api' }
MFMastodonAccount >> password: anObject [
	password := anObject
]

{ #category : #'accessing api' }
MFMastodonAccount >> server [
	^ server
]

{ #category : #'accessing api' }
MFMastodonAccount >> server: anObject [
	server := anObject
]

{ #category : #private }
MFMastodonAccount >> timelineSinceId: anId [
	| timeline |
	timeline := self login timelineHome.
	^ anId
		ifNotNil: [ timeline allSinceId: anId ]
		ifNil: [ timeline last: 200 ]
]

{ #category : #'accessing api' }
MFMastodonAccount >> username [
	^ username
]

{ #category : #'accessing api' }
MFMastodonAccount >> username: anObject [
	username := anObject
]

{ #category : #testing }
MFMastodonAccount >> willExportStatus: aStatus [
	^ (self includeBoosts or: [ (aStatus strippedContent beginsWith: '@') not ])
		and: [ (self includeReplies or: [ aStatus reblog isNil ]) 
		and: [ ((aStatus accountName = self accountName) or: [ aStatus reblogged ])
		and: [ (self isCrosspostOrigin: aStatus applicationName) not ] ] ]
]
