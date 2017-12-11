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
		'password'
	],
	#category : #MastodonFeed
}

{ #category : #'ston-core' }
MFMastodonAccount class >> stonName [
	^ 'Mastodon'
]

{ #category : #accessing }
MFMastodonAccount >> lastUpdateReference [
	^ FileLocator imageDirectory / 'mastodon-', self account acct, '.update.ston'
]

{ #category : #'private factory' }
MFMastodonAccount >> newLogin [
	^ (MdnServer url: self server)
		loginUsername: self username 
		password: self password
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
