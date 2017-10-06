class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_profile, only: [:edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your post couldn't be created! Please add an image and try again."
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @post.destroy
      flash[:success] = "Your post was successfully deleted."
      redirect_to root_path
    else 
      flash[:alert] = "Oh god, something is wrong, please try again"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
  unless @post.user.id == current_user.id
    flash[:alert] = "That post doesn't belong to you!"
    redirect_to root_path
  end
end

end