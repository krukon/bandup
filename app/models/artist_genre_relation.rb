class ArtistGenreRelation < ActiveRecord::Base
	belongs_to :artist
	belongs_to :genre

	validates :artist_id, presence: true
	validates :genre_id, presence: true
end
