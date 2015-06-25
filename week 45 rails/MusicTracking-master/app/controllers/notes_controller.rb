class NotesController < ApplicationController
  def new
    @note = Note.new
    render :new
  end

  def edit
    @note = Note.find_by(params[:id])
    render :edit
  end
  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :new
    end
  end
  end
  def destroy
    @note = Note.find_by(params[:id])
    music_track = @note.track
    @note.destroy
    redirect_to track_url(music_track)
  end
  def update
    @note = Note.find_by(params[:id])
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :edit
    end
  end

  private
  def note_params
    params.require(:note).permit(:durdlings)
  end
end
