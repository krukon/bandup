class BandsController < ApplicationController
  include BandsHelper

  before_action :filter_signed_in, only: [:new, :create]
  before_action :filter_owner, only: [:edit, :update, :destroy]
  before_action :filter_has_request, only: [:accept_request, :remove_request]
  before_action :filter_can_request_join, only: [:join_request]
  before_action :filter_can_be_invited, only: [:invite_artist]

  def index

  end

  def show
    page = params[:id]
    @band = Band.find(:first, conditions: ["lower(page) = ?", page.downcase])

    if @band == nil then
      redirect_to action: :index
    end
  end

  def new
    @band = Band.new
  end

  def create
    data = params[:band]
    name = data[:name]
    page = data[:page]
    begin
      established = data[:established].to_date
    rescue => e
      established = nil
    end
    
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
    page = params[:id]
    @band = Band.find(:first, conditions: ["lower(page) = ?", page.downcase])

    if @band == nil then
      redirect_to action: :index
      return
    end
  end

  def update
    data = params[:band]
    name = data[:name]
    about = data[:about]
    begin
      established = data[:established].to_date
    rescue => e
      established = nil
    end
    
    @band = Band.find(:first, conditions: ["lower(page) = ?", params[:id].downcase])
    
    if @band == nil then
      redirect_to action: :index
      return
    end

    @band.name = name
    @band.about = about
    @band.established = established

    if @band.save then
      flash[:success] = "Band edited successfully."
      redirect_to action: :show, id: @band.page
      return
    end
    render 'edit'
  end

  def destroy
    page = params[:id]
    @band = Band.find(:first, conditions: ["lower(page) = ?", page.downcase])
    if @band != nil then
      @band.destroy!
      flash[:success] = "Band deleted successfully."
    end
    redirect_to action: :index
  end

  def accept_request
    @request.destroy
    @band.artist_relations.create(artist_id: @request.artist_id)
    flash[:success] = "You just joined the band!"
    redirect_to action: :show, id: @band.page
  end

  def remove_request
    @request.destroy
    flash[:info] = "Request removed."
    redirect_to :back
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

    def filter_signed_in
      unless signed_in?
        flash[:info] = "You have to sign in first."
        store_location
        redirect_to controller: :session, action: :new
      end
    end

    def filter_owner
      band = Band.where("lower(page) = ?", params[:id].downcase).take
      unless owner? band
        flash[:error] = "You do not have permissions to edit this band."
        redirect_to action: :show, id: band.page
      end
    end

    def filter_has_request
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      @request = @band.artist_requests.where(artist_id: current_user.id).take
      unless @request
        flash[:error] = "Such request does not exist"
        redirect_to :back
        return
      end
    end

    def filter_can_request_join
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      member = member? @band
      requested = requested? @band
      if member or requested then
        flash[:error] = "You are already a member of this band." if member
        flash[:error] = "You have already sent a join request" if requested
        redirect_to action: :show, id: @band.page
      end
    end

    def filter_can_be_invited
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
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
