class ArtistsController < ApplicationController
  before_action :signed_in_user, only: [
    :band_requests,
    :accept_band_invitation,
    :remove_band_invitation,
    :remove_band_request ]
  before_action :filter_user, only: [:show, :edit, :destroy, :update, :bands]
  before_action :filter_correct_user, only: [:edit, :update]
  before_action :filter_band_request, only: [
    :accept_band_invitation,
    :remove_band_invitation,
    :remove_band_request ]

  def index
    @recent = Artist.order("id DESC").limit(10)
  end


  def show
    @profile_picture = @artist.get_profile_picture(:medium)
    @age = ((DateTime.now - @artist.birthday.to_datetime) / 365).to_i if @artist.birthday != nil;
    @link_facebook = @artist.link_facebook
    @link_youtube = @artist.link_youtube
    @link_website = @artist.link_website
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(create_artist_params)

    if @artist.save
      flash[:success] = "Account created successfully."
      sign_in @artist
      redirect_to action: :edit, id: @artist.username
    else
      flash[:error] = @artist.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit

  end

  def update
    @artist.update_attributes(update_artist_params)
    if @artist.save then
      flash[:success] = "Profile updated."
      redirect_to action: :show, id: @artist.username
    else
      render 'edit'
    end
  end

  def bands
    @bands = @artist.bands
  end

  def band_requests
    @artist = current_user
    @sent = @artist.band_requests.from_artist
    @recieved = @artist.band_requests.from_band
  end

  def accept_band_invitation
    @request.destroy
    @artist.band_relations.create(band_id: @band.id)
    flash[:success] = "You just joined the band!"
    redirect_to band_path(@band.page)
  end

  def remove_band_invitation
    if @request.nil? then
      flash[:error] = "Such invitation does not exist."
    else
      @request.destroy
      flash[:info] = "Invitation removed."
    end
    redirect_to :back
  end

  def remove_band_request
    if @request.nil? then
      flash[:error] = "Such request does not exist."
    else
      @request.destroy
      flash[:info] = "Request removed."
    end
    redirect_to :back
  end

  private

    def create_artist_params
      params.require(:artist).permit(:username, :email, :password)
    end

    def update_artist_params
      params.require(:artist).permit(
        :email, :password, :first_name, :last_name, :stage_name,
        :location_city, :location_state, :birthday,
        :link_facebook, :link_youtube, :link_website)
    end

    def filter_user
      @artist = Artist.find_by(username: params[:id])
      unless @artist
        flash[:error] = "Such artist does not exist."
        redirect_to artists_path
      end
    end

    def filter_correct_user
      artist = Artist.find_by username: params[:id]
      redirect_to action: :show, id: artist.username unless current_user?(artist)
    end

    def filter_band_request
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      unless @band
        flash[:error] = "Such band does not exist."
        redirect_to :back
        return
      end
      @artist = current_user
      @request = @artist.band_requests.find_by(band_id: @band.id)
    end
end
