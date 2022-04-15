class UsersController < ApplicationController
  before_action :load_user

  def show
    @posts = @user.posts
  end

  def followers
    @followers = @user.followers
  end

  def followings
    @followings = @user.followings
  end

  private

  def load_user
    @user = User.find(params[:id])
  end
end
