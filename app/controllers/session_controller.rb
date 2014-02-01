class SessionController < ApplicationController

  # Log in view
  def new
  end

  # Log in
  def create
    username = params[:session][:username]
    password = params[:session][:password]
    artist = Artist.find_by username: username
    if artist then
      if artist.authenticate password then
        # TODO sign in user + redirect to the previous url
        sign_in artist
        flash[:success] = "You are signed in as " + artist.username
        redirect_to controller: :artists, action: :show, id: artist.username
        return
      else
        flash[:error] = "Incorrect password"
      end
    else
      flash[:error] = "Username is incorrect"
    end
    render 'new'
  end

  # Log out
  def destroy
    sign_out
    redirect_to root_path
  end

end
