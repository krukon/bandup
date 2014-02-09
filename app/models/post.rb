class Post < ActiveRecord::Base
	belongs_to :artist
	belongs_to :band
	belongs_to :picture

	validates :artist_id, presence: true
end
