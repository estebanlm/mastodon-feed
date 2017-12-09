Class {
	#name : #MFMastodonAccount,
	#superclass : #Object,
	#instVars : [
		'server',
		'username',
		'password'
	],
	#category : #MastodonFeed
}

{ #category : #'ston-core' }
MFMastodonAccount class >> stonName [
	^ 'Mastodon'
]

{ #category : #accessing }
MFMastodonAccount >> password [
	^ password
]

{ #category : #accessing }
MFMastodonAccount >> password: anObject [
	password := anObject
]

{ #category : #accessing }
MFMastodonAccount >> server [
	^ server
]

{ #category : #accessing }
MFMastodonAccount >> server: anObject [
	server := anObject
]

{ #category : #accessing }
MFMastodonAccount >> username [
	^ username
]

{ #category : #accessing }
MFMastodonAccount >> username: anObject [
	username := anObject
]
