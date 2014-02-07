class PicturesController < ApplicationController
  before_action :signed_in_user
  before_action :filter_picture, only: [:show, :edit, :update, :destroy]
  before_action :filter_owner, only: [:edit, :update, :destroy]

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

  end

  def destroy
    @picture.picture = nil
    @picture.save
    @picture.destroy
    flash[:success] = "Picture deleted successfully."
    redirect_to pictures_path
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
        flash[:error] = "You do not have permission to modify this picture."
        redirect_to :back
      end
    end

end
