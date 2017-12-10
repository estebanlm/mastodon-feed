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
		spec package: 'MastodonFeed' with: [ 
			spec requires: #('Logger' 'Mastodon' 'Twitter') ] ]

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
