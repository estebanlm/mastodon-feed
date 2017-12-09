Class {
	#name : #BaselineOfMastodonFeed,
	#superclass : #BaselineOf,
	#category : #BaselineOfMastodonFeed
}

{ #category : #baselines }
BaselineOfMastodonFeed >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self mastodon: spec.
		self twitter: spec.
		spec package: 'MastodonFeed' with: [ 
			spec requires: #('Mastodon' 'Twitter') ] ]

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
