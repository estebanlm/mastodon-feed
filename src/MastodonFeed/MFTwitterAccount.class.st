"
I'm a twitter account. 
I keep server, username and password.

I can connect with twitter.
"
Class {
	#name : #MFTwitterAccount,
	#superclass : #Object,
	#instVars : [
		'consumerKey',
		'consumerSecret',
		'accessToken',
		'accessTokenSecret'
	],
	#category : #MastodonFeed
}

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
