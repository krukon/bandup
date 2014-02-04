module BandsHelper

	def owner? band
		return false unless signed_in?
		band.artist_relations.find_by(
			owner: true,
			artist_id: current_user.id
		) != nil
	end

	def member? band, user=current_user
		return false unless signed_in?
		band.artist_relations.find_by(artist_id: user.id)
	end

	def requested? band, user=current_user
		return false unless signed_in?
		band.artist_requests.find_by(artist_id: user.id)
	end

end
