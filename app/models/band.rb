class Band < ActiveRecord::Base
	has_many :artist_relations, class_name: "ArtistBandRelation", dependent: :destroy
	has_many :artists, through: :artist_relations
end
