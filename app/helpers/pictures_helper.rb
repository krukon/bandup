module PicturesHelper

	def picture_owner? picture
		return false unless picture
		picture.artist_id == current_user.id
	end

end
