class Api::FeedsController < ApplicationController
  def index
    render :json => current_user.feeds
  end

  def show
    render :json => Feed.find(params[:id]), include: :latest_entries
  end

  def create
    feed = Feed.find_or_create_by_url(feed_params[:url])
    if feed
      Subscription.create!(user_id: current_user.id, feed_id: feed.id);
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    render json: feed
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
