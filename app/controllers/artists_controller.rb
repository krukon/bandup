class ArtistsController < ApplicationController
  def index

  end


  def show
    username = params[:id]
    @artist = Artist.find_by(username: username)
    if (@artist == nil) then
      redirect_to artists_path
    end
    @image = "fake.jpg";
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

    redirect_to action: :edit, id: @artist.username
  end

  def edit
    @artist = Artist.find_by(username: params[:id])
  end

  def update
    username = params[:id]
    data = params[:artist]
    @artist = Artist.find_by(username: username)
    @artist.email = data[:email]
    @artist.first_name = data[:first_name]
    @artist.last_name = data[:last_name]
    @artist.stage_name = data[:stage_name]
    @artist.location_city = data[:location_city]
    @artist.location_state = data[:location_state]
    @artist.link_facebook = extract_link data[:link_facebook]
    @artist.link_youtube = extract_link data[:link_youtube]
    @artist.link_website = extract_link data[:link_website]
    @artist.birthday = extract_date data, :birthday
    if @artist.birthday == nil then
      @artist.errors.add :birthday, "date is invalid"
      @artist.valid?
      render 'edit'
      return
    end
    if @artist.save then
      flash[:success] = "Profile updated."
      redirect_to action: :show, id: @artist.username
    else
      render 'edit'
    end
  end

  private

    def extract_date data, field
      year = data[field.to_s + '(1i)'].to_i
      month = data[field.to_s + '(2i)'].to_i
      day = data[field.to_s + '(3i)'].to_i
      begin
        date = DateTime.new(year, month, day)
      rescue => e
        return nil
      end
      date
    end

    def extract_link link
      link = "http://" + link if !link.starts_with? "http://" and !link.starts_with? "https://"
      link
    end

end
