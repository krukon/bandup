module ArtistsHelper

	def extract_link link, www = true
		link.sub!("https://", "") if link.starts_with? "https://"
		link.sub!("http://", "") if link.starts_with? "http://"
		link.sub!("www.", "") if (www and link.starts_with? "www.")
		link
	end

end
