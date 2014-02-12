class Picture < ActiveRecord::Base
  belongs_to :artist
  has_attached_file :picture,
    storage: :dropbox,
    dropbox_credentials: Rails.root.join("config/dropbox.yml"),
    dropbox_options: {
      path: proc { |style| "pictures/#{get_hash}" }
    },
    styles: { original: "600x600>", medium: "240x240#", thumb: "80x80#" }

  validates_attachment :picture, presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    size: { in: 0..1.megabyte }

  def get_hash
    Digest::SHA1.hexdigest id.to_s + picture_file_name + created_at.to_s
  end

end
