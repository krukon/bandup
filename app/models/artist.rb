class Artist < ActiveRecord::Base
  has_secure_password validations: false

  has_many :band_relations, class_name: "ArtistBandRelation", dependent: :destroy
  has_many :bands, through: :band_relations
  has_many :band_requests, class_name: "ArtistBandJoinRequest", dependent: :destroy
  has_many :instrument_relations, class_name: "ArtistInstrumentRelation", dependent: :destroy
  has_many :instruments, through: :instrument_relations
  has_many :genre_relations, class_name: "ArtistGenreRelation", dependent: :destroy
  has_many :genres, through: :genre_relations
  has_many :pictures, class_name: "Picture", dependent: :destroy
  belongs_to :profile_picture, class_name: "Picture", dependent: :destroy
  belongs_to :cover_picture, class_name: "Picture", dependent: :destroy


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

  def birthday=(raw)
    value = nil
    begin
      value = raw if raw.class == Date or raw.class == DateTime
      value = raw.to_date if raw.class == String
    rescue => e
    end
    write_attribute(:birthday, value)
  end

  def link_facebook=(value)
    write_attribute(:link_facebook, get_url(value))
  end

  def link_youtube=(value)
    write_attribute(:link_youtube, get_url(value))
  end

  def link_website=(value)
    write_attribute(:link_website, get_url(value))
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

  def get_printable_name
    result = get_full_name
    result = read_attribute(:username) if result.blank?
    result.squish
  end

  def get_profile_picture type
    return "/assets/fake.jpg" unless profile_picture && type.class == Symbol
    profile_picture.picture.url(type)
  end

  private

    def get_url(value)
      ("http://" if value.squish.scan(/\Ahttps?:\/{2}/).count == 0).to_s + value
    end

end
