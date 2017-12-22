"
I will cosspost twitter-to-mastodon.
"
Class {
	#name : #MFFeedDirectionTwitterToMastodon,
	#superclass : #MFFeedDirection,
	#category : #MastodonFeed
}

{ #category : #accessing }
MFFeedDirectionTwitterToMastodon class >> label [ 
	^ 'twitter-to-mastodon'
]

{ #category : #updating }
MFFeedDirectionTwitterToMastodon >> updateOn: aFeed [
	aFeed updateTwitterToMastodon
]
