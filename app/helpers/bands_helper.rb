module BandsHelper

	def owner? band
		band.artist_relations.find_by(
			owner: true,
			artist_id: current_user.id
		) != nil
	end

	def member? band, user=current_user
		band.artist_relations.find_by(artist_id: user.id)
	end

	def requested? band, user=current_user
		band.artist_requests.find_by(artist_id: user.id)
	end

end
