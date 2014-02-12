class PicturesController < ApplicationController
  before_action :signed_in_user
  before_action :filter_artist, only: [:artist_index, :artist_show]
  before_action :filter_picture, only: [:show, :edit, :update, :destroy,
    :artist_show, :change_profile]
  before_action :filter_owner, only: [:edit, :update, :destroy, :change_profile]

  def index
    @recent = Picture.order("id DESC").limit(10)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.artist = current_user
    if !@picture.save
      render 'new'
      return
    end
    
    redirect_to picture_path(id: @picture.id)
  end

  def edit
    
  end

  def update
    @picture.update_attributes(picture_update_params)
    flash[:success] = "Picture updated."
    redirect_to picture_path(@picture)
  end

  def show
    @back_path = pictures_path()
  end

  def destroy
    @picture.picture = nil
    @picture.save
    @picture.destroy
    flash[:success] = "Picture deleted successfully."
    redirect_to pictures_path
  end

  def artist_index
    @pictures = @artist.pictures.order("id DESC")
  end

  def artist_show
    @back_path = artist_pictures_path(@artist.username)
    render 'show'
  end

  def select_profile
    @artist = current_user
    @pictures = @artist.pictures.order("id DESC")
  end

  def change_profile
    @artist = current_user
    @artist.profile_picture_id = @picture.id
    @artist.save
    redirect_to artist_path(@artist.username)
  end

  private

    def picture_params
      params.require(:picture).permit(:picture, :title, :description)
    end

    def picture_update_params
      params.require(:picture).permit(:title, :description)
    end

    def filter_picture
      @picture = Picture.find_by(id: params[:id])
      unless @picture
        flash[:error] = "Such picture does not exist."
        redirect_to pictures_path
      end
    end

    def filter_owner
      @artist = current_user
      unless @artist.id == @picture.artist_id
        flash[:error] = "This is not a picture of yours."
        redirect_to :back
      end
    end

    def filter_artist
      @artist = Artist.find_by(username: params[:username])
      unless @artist
        flash[:error] = "Such artist does not exist."
        redirect_to pictures_path
      end
    end

end
