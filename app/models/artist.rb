class Artist < ActiveRecord::Base
  has_secure_password

  has_many :band_relations, class_name: "ArtistBandRelation", dependent: :destroy
  has_many :bands, through: :band_relations
  has_many :instrument_relations, class_name: "ArtistInstrumentRelation", dependent: :destroy
  has_many :instruments, through: :instrument_relations
end
