class Artist < ActiveRecord::Base
  has_secure_password validations: false

  has_many :band_relations, class_name: "ArtistBandRelation", dependent: :destroy
  has_many :bands, through: :band_relations
  has_many :band_requests, class_name: "ArtistBandJoinRequest", dependent: :destroy
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
  #validates :birthday, presence: true

  def Artist.generate_token
    SecureRandom.urlsafe_base64
  end

  def Artist.encrypt token
    Digest::SHA1.hexdigest token.to_s
  end

  def get_full_name
    result = read_attribute(:stage_name)
    name = get_legal_name
    return name if result.blank?
    result += " (" + name + ")" if !name.blank?
    result.squish
  end

  def get_legal_name
    (read_attribute(:first_name).to_s + " " + read_attribute(:last_name).to_s).squish
  end

end
