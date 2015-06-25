class UserCommentsController < ApplicationController
  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.author_id = current_user.id
    unless @user_comment.save
      flash[:errors] = @user_comment.errors.full_messages
    end
    redirect_to user_url(current_user)
  end

  def destroy
    @user_comment = UserComment.find(params[:id])
    @user_comment.destroy
    redirect_to user_url(current_user)
  end

  private
  def user_comment_params
    params.require(:user_comment).permit(:body, :user_id)
  end

end
