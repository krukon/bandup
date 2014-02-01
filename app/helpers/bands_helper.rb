module BandsHelper

	def owner? band
		band.artist_relations.find_by(
			owner: true,
			artist_id: current_user.id
		) != nil
	end

end
