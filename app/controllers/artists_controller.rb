class ArtistsController < ApplicationController
  def index

  end


  def show
    name = params[:id]
    @artist = Artist.find_by(username: name)
    if (@artist == nil) then
      redirect_to artists_path
    end
    @image = "fake.jpg";
    @age = ((DateTime.now - @artist.birthday.to_datetime) / 365).to_i;
    @location = @artist.location_city + ", " + @artist.location_state
    @link_facebook = @artist.link_facebook
    @link_youtube = @artist.link_youtube
    @link_website = @artist.link_website
  end

  def new

  end
end
