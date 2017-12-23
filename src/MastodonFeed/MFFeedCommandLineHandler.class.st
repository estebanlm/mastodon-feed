"
Execute mastodon-feed updates. 

Usage: [-h] [-P] account1.ston [account2.ston ...]
	-h                               Show this help message.
	-T                               Prints an account template.
	
account1.ston... accountN.ston are the accounts to process.

"
Class {
	#name : #MFFeedCommandLineHandler,
	#superclass : #CommandLineHandler,
	#instVars : [
		'keepAlive'
	],
	#category : #MastodonFeed
}

{ #category : #accessing }
MFFeedCommandLineHandler class >> commandName [
	^ 'mastodon-feed'
]

{ #category : #accessing }
MFFeedCommandLineHandler class >> description [
	^ 'A front-end for mastodon-feed application.'
]

{ #category : #activation }
MFFeedCommandLineHandler >> activate [
	| fileNames printHelp printTemplate |
	
	keepAlive := printHelp := printTemplate := false.
	fileNames := OrderedCollection new.
	
	"parse arguments"
	GetOpt new
		at: $k put: [ :opt | keepAlive := true ];
		at: $h put: [ :opt | printHelp := true ];
		at: $T put: [ :opt | printTemplate := true ];
		at: $? put: [ :opt | self error: 'Illegal option -', opt asString ];
		default: [ :arg | fileNames add: arg ];
		parse: self arguments.
	
	printHelp ifTrue: [ self withPostProcessDo: [ self printHelp ]  ].
	printTemplate ifTrue: [ self withPostProcessDo: [ self printTemplate ] ].

	fileNames ifEmpty: [ self error: 'You need to specify at least one feed to read!' ].	
	"process feeds"
	self withPostProcessDo: [ 
		self processFeeds: fileNames ].
]

{ #category : #activation }
MFFeedCommandLineHandler >> printTemplate [
	Stdio stdout << ('Feed { 
	#direction : ''cross-posting'',
	#mastodonAccount : Mastodon {
		#server : ''https://mastodon.social'',
		#username : ''johndoe@mail.net'',
		#password : ''shh'',
		#includeBoosts : true,
		#includeReplies: false
	}, 
	#twitterAccount : Twitter {
		#consumerKey : ''CONSUMER_KEY'',
		#consumerSecret : ''CONSUMER_SECRET'',
		#accessToken : ''ACCESS_TOKEN'',
		#accessTokenSecret : ''ACCESS_TOKEN_SECRET'',
		#includeRTs: true,
		#includeReplies: false
	}
}	
' withLineEndings: OSPlatform current lineEnding).
]

{ #category : #activation }
MFFeedCommandLineHandler >> processFeeds: fileNames [
	Logger logToConsole.
	fileNames 
		collect: [ :each | MFFeed fromReference: each asFileReference ]
		thenDo: #update.
	Logger stopLogging
]

{ #category : #private }
MFFeedCommandLineHandler >> quitIfEnabled [
	keepAlive ifTrue: [ ^ self ]. 
	self quit
]

{ #category : #private }
MFFeedCommandLineHandler >> withPostProcessDo: aBlock [
	aBlock value.
	self quitIfEnabled
]
