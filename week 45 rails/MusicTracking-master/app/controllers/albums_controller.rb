class AlbumsController < ApplicationController
  before_action :require_login
  def new
    @album = Album.new
    @band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end


  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    @album.destroy
    redirect_to band_url(band)
  end

  def index
    render :index
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @band_id = @album.band_id
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private
  def album_params
    params.require(:album).permit(:name, :album_recording_type, :band_id)
  end
end
