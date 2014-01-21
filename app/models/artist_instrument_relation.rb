class ArtistInstrumentRelation < ActiveRecord::Base
	belongs_to :artist
	belongs_to :instrument

	validates :artist_id, presence: true
	validates :instrument_id, presence: true
end
