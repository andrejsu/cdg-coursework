class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end
end
