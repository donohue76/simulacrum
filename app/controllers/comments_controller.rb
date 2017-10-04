class CommentsController < ApplicationController
  before_action :set_post
  # returning all of the comments for a post in ascending order
  def index
    @comments = @post.comments.order("created_at ASC")
    # responding to html(as the default) and requesting that the applications layout view is only rendered as part of this request, IF the request isn't made with AJAX.
    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Check the comment form, something went wrong."
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
