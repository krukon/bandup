class ArtistBandJoinRequest < ActiveRecord::Base
  belongs_to :artist
  belongs_to :band

  validates :artist_id, uniqueness: { scope: :band_id, message: "- Band request already created" }

  scope :from_artist, -> { where(band_accepted: false) }
  scope :from_band, -> { where(artist_accepted: false) }
end