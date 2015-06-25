class SessionsController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      log_in(@user)
      redirect_to ""
    else
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
