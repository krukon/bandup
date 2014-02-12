class BandsController < ApplicationController
  include BandsHelper

  before_action :filter_band, except: [:index, :new, :create]
  before_action :filter_artist, only: [:invite_artist, :remove_member,
    :accept_request, :remove_request, :remove_invitation]
  before_action :filter_signed_in, except: [:index, :show, :members]
  before_action :filter_is_owner, only: [:edit, :update, :destroy, :requests,
    :accept_request, :remove_request, :remove_invitation]
  before_action :filter_is_member, only: [:leave_band]
  before_action :filter_member, only: [:remove_member]
  before_action :filter_can_request_join, only: [:join_request]
  before_action :filter_can_be_invited, only: [:invite_artist]
  before_action :filter_requests, only: [:accept_request, :remove_request]
  before_action :filter_invitation, only: [:remove_invitation]

  def index
    @recent = Band.order("id DESC").take(10)
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

  def members

  end

  def remove_member
    @band.artist_relations.find_by(artist_id: @artist.id).destroy
    flash[:info] = "Artist removed from the band."
    redirect_to :back
  end

  def requests
    @received = @band.artist_requests.where(artist_accepted: true)
    @sent = @band.artist_requests.where(band_accepted: true)
  end

  def accept_request
    @request.destroy
    @band.artist_relations.create(artist_id: @artist.id)
    flash[:success] = "Membership request accepted."
    redirect_to :back
  end

  def remove_request
    @request.destroy
    flash[:info] = "Membership request removed."
    redirect_to :back
  end

  def remove_invitation
    @invitation.destroy
    flash[:info] = "Invitation removed."
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

  def leave_band
    @band.artist_relations.find_by(artist_id: current_user.id).destroy
    flash[:info] = "You just left this band."
    redirect_to band_path(@band.page)
  end

  private

    def filter_band
      @band = Band.where("lower(page) = ?", params[:id].downcase).take
      unless @band
        flash[:error] = "Such band does not exist."
        redirect_to bands_path
      end
    end

    def filter_artist
      @artist = Artist.find_by(username: params[:username])
      unless @artist
        flash[:error] = "Such artist does not exist."
        redirect_to :back
        return
      end
    end

    def filter_signed_in
      unless signed_in?
        flash[:info] = "You have to sign in first."
        store_location
        redirect_to signin_path
      end
    end

    def filter_is_owner
      unless owner? @band
        flash[:error] = "You do not have permissions to edit this band."
        redirect_to action: :show, id: @band.page
      end
    end

    def filter_is_member
      unless member? @band, current_user
        flash[:error] = "You are not a member of this band."
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
      member = member? @band, @artist
      requested = requested? @band, @artist
      if member or requested then
        flash[:error] = "This artist is already a member of this band." if member
        flash[:error] = "This artist has already got a join request." if requested
        redirect_to action: :show, id: @band.page
      end
    end

    def filter_member
      unless member?(@band, @artist)
        flash[:error] = "This artist is not a member of this band."
        redirect_to :back
        return
      end
    end

    def filter_requests
      @request = @band.artist_requests.find_by(artist_id: @artist.id, band_accepted: false)
      unless @request
        flash[:error] = "Such request does not exist."
        redirect_to :back
      end
    end

    def filter_invitation
      @invitation = @band.artist_requests.find_by(artist_id: @artist.id, artist_accepted: false)
      unless @invitation
        flash[:error] = "Such invitation does not exist."
        redirect_to :back
      end
    end

end
