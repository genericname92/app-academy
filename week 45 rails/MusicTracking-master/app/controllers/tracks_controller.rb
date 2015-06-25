class TracksController < ApplicationController
  before_action :require_login
  def new
    @track = Track.new
    @album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end


  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    @track.destroy
    redirect_to album_url(album)
  end

  def index
    render :index
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @album_id = @track.album_id
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :track_bonus, :album_id, :lyrics)
  end
end
