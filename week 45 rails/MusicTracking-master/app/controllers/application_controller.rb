class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil if session[:session_token].nil?
    current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in"
      redirect_to new_session_url
    end
  end


  helper_method :logged_in?
  helper_method :current_user
end
