class CheckpointsController < ApplicationController
  before_action :must_log_in
  def create
    @checkpoint = Checkpoint.new(checkpoint_params)
    @checkpoint.user_id = current_user.id
    unless @checkpoint.save
      flash[:errors] = @checkpoint.errors.full_messages
    end
    redirect_to user_url(current_user)
  end

  def edit
    @checkpoint = Checkpoint.find(params[:id])
  end

  def update
    @checkpoint = Checkpoint.find(params[:id])
    if @checkpoint.update(checkpoint_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @checkpoint.errors.full_messages
      render :edit
    end
  end

  def destroy
    @checkpoint = Checkpoint.find(params[:id])
    @checkpoint.destroy
    redirect_to user_url(current_user)
  end

  private
  def checkpoint_params
    params.require(:checkpoint).permit(:title, :viewable)
  end
end
