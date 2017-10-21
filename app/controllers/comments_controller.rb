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
  
  # build a comment based on the comment params and assign a user id. If the comment saves, we respond with some javascript that updates the user's page and creates a notification
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      create_notification @post, @comment
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

  def create_notification(post, comment)
    return if post.user.id == current_user.id 
    Notification.create(user_id: post.user.id, notified_by_id: current_user.id, post_id: post.id, comment_id: comment.id, notice_type: 'comment')
  end
end
