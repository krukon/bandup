class BandsController < ApplicationController
  include BandsHelper

  before_action :filter_band, except: [:index, :new, :create]
  before_action :filter_signed_in, only: [:new, :create]
  before_action :filter_owner, only: [:edit, :update, :destroy]
  before_action :filter_can_request_join, only: [:join_request]
  before_action :filter_can_be_invited, only: [:invite_artist]

  def index

  end

  def show

  end

  def new
    @band = Band.new
  end

  def create
    data = params[:band]
    name = data[:name]
    page = data[:page]
    established = data[:established]
    
    @band = Band.new(name: name, page: page, established: established)

    if @band.save then
      current_user.band_relations.create(band_id: @band.id, owner: true)
      flash[:success] = "Band created successfully."
      redirect_to action: :show, id: @band.page
      return
    end
    render 'new'
  end

  def edit

  end

  def update
    data = params[:band]

    @band.name = data[:name]
    @band.about = data[:about]
    @band.established = data[:established]

    if @band.save then
      flash[:success] = "Band edited successfully."
      redirect_to action: :show, id: @band.page
      return
    end
    render 'edit'
  end

  def destroy
    @band.destroy
    flash[:success] = "Band deleted successfully."
    redirect_to action: :index
  end

  def join_request
    @band.artist_requests.create(artist_id: current_user.id, artist_accepted: true)
    flash[:success] = "Request sent."
    redirect_to :back
  end

  def invite_artist
    @band.artist_requests.create(artist_id: @artist.id, band_accepted: true)
    flash[:success] = "Invitation sent."
    redirect_to :back
  end

  private

    def filter_band
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      unless @band
        flash[:error] = "Such band does not exist."
        redirect_to bands_path
      end
    end

    def filter_signed_in
      unless signed_in?
        flash[:info] = "You have to sign in first."
        store_location
        redirect_to signin_path
      end
    end

    def filter_owner
      unless owner? @band
        flash[:error] = "You do not have permissions to edit this band."
        redirect_to action: :show, id: @band.page
      end
    end

    def filter_can_request_join
      member = member? @band
      requested = requested? @band
      if member or requested then
        flash[:error] = "You are already a member of this band." if member
        flash[:error] = "You have already sent a join request" if requested
        redirect_to action: :show, id: @band.page
      end
    end

    def filter_can_be_invited
      @artist = Artist.find_by(username: params[:username])
      member = member? @band, @artist
      requested = requested? @band, @artist
      if member or requested then
        flash[:error] = "This artist is already a member of this band." if member
        flash[:error] = "This artist has already got a join request." if requested
        redirect_to action: :show, id: @band.page
      end
    end

end
