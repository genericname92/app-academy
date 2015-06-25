class PostsController < ApplicationController
  def index
    @posts = Post.all
    render :json => @posts
  end

  def show
    @post = Post.find(params[:id])
    render :json => @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render :json => @post
    else
      render :json => {errors: @post.errors.full_messages}, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render :json => {}
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      sleep 2
      render :json => @post
    else
      render :json => {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:body, :title)
  end
end
