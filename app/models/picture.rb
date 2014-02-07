class Picture < ActiveRecord::Base
	belongs_to :artist
	has_attached_file :picture, styles: { medium: "240x240#", thumb: "80x80#" }
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*Z/
end
