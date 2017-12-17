Class {
	#name : #BaselineOfMastodonFeed,
	#superclass : #BaselineOf,
	#category : #BaselineOfMastodonFeed
}

{ #category : #baselines }
BaselineOfMastodonFeed >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self logger: spec.
		self mastodon: spec.
		self twitter: spec.
		self html: spec.
		spec package: 'MastodonFeed' with: [ 
			spec requires: #('Logger' 'Mastodon' 'Twitter' 'XMLParserHTML') ] ]

]

{ #category : #'external projects' }
BaselineOfMastodonFeed >> html: spec [
	spec 
		configuration: 'XMLParserHTML'
		with: [ 
			spec 
				version: '1.4.0';
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main' ]
]

{ #category : #'external projects' }
BaselineOfMastodonFeed >> logger: spec [
	spec 
		baseline: 'Logger'
		with: [ spec repository: 'github://estebanlm/logger/src' ]	
]

{ #category : #'external projects' }
BaselineOfMastodonFeed >> mastodon: spec [
	spec 
		baseline: 'Mastodon'
		with: [ spec repository: 'github://estebanlm/pharo-mastodon/src' ]
]

{ #category : #'external projects' }
BaselineOfMastodonFeed >> twitter: spec [
	spec 
		baseline: 'Twitter'
		with: [ spec repository: 'github://estebanlm/pharo-twitter/src' ]
]
