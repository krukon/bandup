class ArtistsController < ApplicationController
  before_action :filter_correct_user, only: [:edit, :update]
  before_action :filter_signed_in, only: [:band_requests]
  before_action :filter_band, only:
      [:accept_band_invitation, :remove_band_invitation, :remove_band_request]
  before_action :filter_request, only:
      [:accept_band_invitation, :remove_band_invitation, :remove_band_request]

  def index
    @recent = Artist.order("id DESC").limit(10)
  end


  def show
    username = params[:id]
    @artist = Artist.find_by(username: username)
    if (@artist == nil) then
      redirect_to artists_path
    end
    @profile_picture = @artist.profile_picture ?
      @artist.profile_picture.picture.url(:medium) : "/assets/fake.jpg";
    @age = ((DateTime.now - @artist.birthday.to_datetime) / 365).to_i if @artist.birthday != nil;
    @link_facebook = @artist.link_facebook
    @link_youtube = @artist.link_youtube
    @link_website = @artist.link_website
  end

  def new
    @artist = Artist.new
  end

  def create
    data = params[:artist]
    username = data[:username]
    email = data[:email]
    password = data[:password]

    @artist = Artist.create!(username: username, email: email, password: password)

    signed_in @artist
    redirect_to action: :edit, id: @artist.username
  end

  def edit
    @artist = Artist.find_by(username: params[:id])
  end

  def update
    username = params[:id]
    data = params[:artist]
    @artist = Artist.find_by(username: username)
    save_attributes @artist, data
    if @artist.save then
      flash[:success] = "Profile updated."
      redirect_to action: :show, id: @artist.username
    else
      render 'edit'
    end
  end

  def bands
    username = params[:id]
    @artist = Artist.find_by(username: username)
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

    def extract_link link
      link = "http://" + link if !link.starts_with? "http://" and !link.starts_with? "https://"
      link
    end

    def save_attributes artist, data
      artist.email = data[:email]
      artist.first_name = data[:first_name]
      artist.last_name = data[:last_name]
      artist.stage_name = data[:stage_name]
      artist.location_city = data[:location_city]
      artist.location_state = data[:location_state]
      artist.link_facebook = extract_link data[:link_facebook]
      artist.link_youtube = extract_link data[:link_youtube]
      artist.link_website = extract_link data[:link_website]
      artist.birthday = data[:birthday]
    end

    def filter_correct_user
      artist = Artist.find_by username: params[:id]
      redirect_to action: :show, id: artist.username unless current_user?(artist)
    end

    def filter_signed_in
      signed_in?
      # TODO Change into signed_in_user  @SesstionHelper
    end

    def filter_band
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      unless @band
        flash[:error] = "Such band does not exist."
        redirect_to :back
      end
    end

    def filter_request
      @artist = current_user
      @request = @artist.band_requests.find_by(band_id: @band.id)
    end

end
