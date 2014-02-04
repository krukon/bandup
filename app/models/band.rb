class Band < ActiveRecord::Base
  has_many :artist_relations, class_name: "ArtistBandRelation", dependent: :destroy
  has_many :artists, through: :artist_relations
  has_many :artist_requests, class_name: "ArtistBandJoinRequest", dependent: :destroy

  validates :name, presence: true
  validates :page, presence: true, uniqueness: { case_sensitive: false },
      format: {
        with: /\A[\w\-\.\~]+\Z/, 
        message: "can contain alphanumerical and _ - . ~ characters only. "
      }


  def established=(raw)
    value = nil
    begin
      value = raw if raw.class == Date or raw.class == DateTime
      value = raw.to_date if raw.class == String
    rescue => e
    end
    write_attribute(:established, value)
  end
end