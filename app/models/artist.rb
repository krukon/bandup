class Artist < ActiveRecord::Base
  has_secure_password validations: false

  has_many :band_relations, class_name: "ArtistBandRelation", dependent: :destroy
  has_many :bands, through: :band_relations
  has_many :instrument_relations, class_name: "ArtistInstrumentRelation", dependent: :destroy
  has_many :instruments, through: :instrument_relations
  has_many :genre_relations, class_name: "ArtistGenreRelation", dependent: :destroy
  has_many :genres, through: :genre_relations


  validates :username, presence: true,
                      length: { maximum: 50 },
                      uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                      length: { within: 4..50 },
                      if: -> e { not e.persisted? or e.password.present? }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
