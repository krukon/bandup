class Picture < ActiveRecord::Base
  belongs_to :artist
  has_attached_file :picture,
    styles: { original: "600x600>", medium: "240x240#", thumb: "80x80#" },
    url: "/system/pictures/:style/:hash.:extension",
    hash_secret: "cfa6a4c6-02ac-454b-acfb-a18cbd51aa0c"

  validates_attachment :picture, presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    size: { in: 0..1.megabyte }


end
