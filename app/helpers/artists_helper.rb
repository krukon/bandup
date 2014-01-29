module ArtistsHelper

  def extract_link link, www = true
    link.sub!("https://", "") if link.starts_with? "https://"
    link.sub!("http://", "") if link.starts_with? "http://"
    link.sub!("www.", "") if (www and link.starts_with? "www.")
    link
  end

  def get_name e
    result = ""
    result += e.first_name if !e.first_name.blank?
    result += " " if !e.first_name.blank? and !e.last_name.blank?
    result += e.last_name if !e.last_name.blank?
    return nil if result.blank?
    result
  end

  def get_location e
    result = ""
    result += e.location_city if !e.location_city.blank?;
    result += ", " if !e.location_city.blank? and !e.location_state.blank?;
    result += e.location_state if !e.location_state.blank?;
    return nil if result.blank?
    result
  end

end
