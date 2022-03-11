class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:id])
    @followers = @user.followings
  end
end
