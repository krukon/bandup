class ArtistsController < ApplicationController
  def index

  end


  def show
    name = params[:id]
    @artist = Artist.find_by(username: name)
    @image = "fake.jpg";
    if (@artist == nil) then
      redirect_to artists_path
    end
  end

  def new

  end
end
