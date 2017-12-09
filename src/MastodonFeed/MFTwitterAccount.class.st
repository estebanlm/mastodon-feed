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
	#superclass : #Object,
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

{ #category : #accessing }
MFTwitterAccount >> accessToken [
	^ accessToken
]

{ #category : #accessing }
MFTwitterAccount >> accessToken: anObject [
	accessToken := anObject
]

{ #category : #accessing }
MFTwitterAccount >> accessTokenSecret [
	^ accessTokenSecret
]

{ #category : #accessing }
MFTwitterAccount >> accessTokenSecret: anObject [
	accessTokenSecret := anObject
]

{ #category : #accessing }
MFTwitterAccount >> consumerKey [
	^ consumerKey
]

{ #category : #accessing }
MFTwitterAccount >> consumerKey: anObject [
	consumerKey := anObject
]

{ #category : #accessing }
MFTwitterAccount >> consumerSecret [
	^ consumerSecret
]

{ #category : #accessing }
MFTwitterAccount >> consumerSecret: anObject [
	consumerSecret := anObject
]

{ #category : #accessing }
MFTwitterAccount >> includeRTs [
	"OPTIONAL: indicates if the query needs to include retwits (default: false)"
	^ includeRTs ifNil: [ includeRTs := self class defaultIncludeRTs ]
]

{ #category : #accessing }
MFTwitterAccount >> includeRTs: anObject [
	includeRTs := anObject
]

{ #category : #accessing }
MFTwitterAccount >> username [
	"OPTIONAL: the username timeline to query. When I'm 'sniffing' an user account is not mine, 
	 I need to take the twites by querying their public timeline."
	^ username
]

{ #category : #accessing }
MFTwitterAccount >> username: anObject [
	username := anObject
]
