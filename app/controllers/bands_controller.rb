class BandsController < ApplicationController

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

end
