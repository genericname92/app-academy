class StaticPagesController < ApplicationController
  def index
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
