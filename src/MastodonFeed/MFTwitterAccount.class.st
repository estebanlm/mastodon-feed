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
		'includeRTs'
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
	self halt
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
MFTwitterAccount >> lastUpdateReference [
	^ FileLocator imageDirectory / ('twitter-', self accountName, '.update.ston')
]

{ #category : #'private factory' }
MFTwitterAccount >> newLogin [
	^ TwiLogin 
	consumerKey: self consumerKey
	consumerSecret: self consumerSecret
	accessToken: self accessToken
	accessTokenSecret: self accessTokenSecret
]

{ #category : #private }
MFTwitterAccount >> timelineSinceId: anId [
	^ self login timelineUser 
		username: self username;
		includeRTs: self includeRTs;
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
