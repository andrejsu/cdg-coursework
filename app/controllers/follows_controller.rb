class FollowsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    render 'follows/create'
  end

  def destroy
    @user = Follow.find(params[:id]).following
    current_user.unfollow(@user)
    render 'follows/destroy'
  end
end
