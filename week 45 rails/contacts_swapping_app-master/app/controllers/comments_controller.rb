class CommentsController < ApplicationController
  def find_commentable
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
  end

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      #flash[:notice] = "Successfully saved comment."
      render text: "No Comment!"  
    else
      render :action => 'new'
    end
  end
end
