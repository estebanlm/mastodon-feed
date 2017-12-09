Class {
	#name : #MFFeedDirectionMastodonToTwitter,
	#superclass : #MFFeedDirection,
	#category : #MastodonFeed
}

{ #category : #accessing }
MFFeedDirectionMastodonToTwitter class >> label [ 
	^ 'mastodon-to-twitter'
]

{ #category : #updating }
MFFeedDirectionMastodonToTwitter >> updateOn: aFeed [
	aFeed updateMastodonToTwitter
]
