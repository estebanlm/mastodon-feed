"
I will cosspost in both directions: mastodon-to-twitter and twitter-to-mastodon.
"
Class {
	#name : #MFFeedDirectionCrossPosting,
	#superclass : #MFFeedDirection,
	#category : #MastodonFeed
}

{ #category : #accessing }
MFFeedDirectionCrossPosting class >> label [ 
	^ 'cross-posting'
]

{ #category : #updating }
MFFeedDirectionCrossPosting >> updateOn: aFeed [
	aFeed updateTwitterToMastodon.
	aFeed updateMastodonToTwitter
]
