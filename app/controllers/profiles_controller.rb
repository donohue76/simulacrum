class ProfilesController < ApplicationController
  before_action :set_user
  
  #  gets a user object then calls .posts at the end to get all the posts for that user, and orders the posts in descending order.
  def show
    # gives us the user object for the current profile we're looking at.
    @user = User.find_by(user_name: params[:user_name])
    @posts = User.find_by(user_name: params[:user_name]).posts.order('created_at DESC')
  end
  # we just want to be able to update two specific parts of the user object in the form, the bio and avatar.
  def edit
    @user = User.find_by(user_name: params[:user_name])
  end


  def update
    # set the @user instance variable by finding their details via the url params (users user name)
    @user = User.find_by(user_name: params[:user_name])
    # if we can update the user object with the profile params sent by the form, flash a success message and redirect back to their profile page.
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    else
      # if something goes wrong, flash an error message and render the edit page once again, with the users form entries intact
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end


  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

  before_action :authenticate_user!

# prevents anyone but the owner of the profile from editing that profile

  def owned_profile
    @user = User.find_by(user_name: params[:user_name])
    unless current_user == @user
      flash[:alert] = "That profile does not belong to you!"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end
end
