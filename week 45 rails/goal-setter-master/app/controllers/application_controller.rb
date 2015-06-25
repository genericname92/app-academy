class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def sign_in(user)
    session[:session_token] = user.session_token
  end

  def sign_out
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def signed_in?
    !!current_user
  end

  def must_log_in
    if !signed_in?
      flash[:errors] = ["Must Log In"]
      redirect_to new_session_url
    end
  end

  helper_method :current_user
  helper_method :signed_in?
end
