class UsersController < ApplicationController
  before_action :must_log_in, only: [:show, :index]


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @public_goals = @user.checkpoints.select { |goal| goal.viewable == "public" }
    @private_goals = @user.checkpoints.select { |goal| goal.viewable == "private" }
    @user_id = params[:id]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
