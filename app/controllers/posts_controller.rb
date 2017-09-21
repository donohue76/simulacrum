class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to @post
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

end