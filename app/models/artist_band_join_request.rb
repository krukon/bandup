class ArtistBandJoinRequest < ActiveRecord::Base
  belongs_to :artist
  belongs_to :band

  validates :artist_id, uniqueness: { scope: :band_id, message: "- Band request already created" }
end