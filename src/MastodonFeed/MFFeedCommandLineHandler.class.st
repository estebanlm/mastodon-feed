Class {
	#name : #MFFeedCommandLineHandler,
	#superclass : #CommandLineHandler,
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
	| fileNames keepAlive |
	
	keepAlive := false.
	fileNames := OrderedCollection new.
	
	"parse arguments"
	GetOpt new
		at: $k put: [ :opt | keepAlive := true ];
		at: $? put: [ :opt | self error: 'Illegal option -', opt asString ];
		default: [ :arg | fileNames add: arg ];
		parse: self arguments.	
	fileNames ifEmpty: [ self error: 'You need to specify at least one feed to read!' ].
		
	"process feeds"
	Logger logToConsole.
	fileNames 
		collect: [ :each | MFFeed fromReference: each asFileReference ]
		thenDo: #update.
	Logger stopLogging.
	
	"get out"
	keepAlive ifFalse: [ 
		Smalltalk snapshot: false andQuit: true ]
]
