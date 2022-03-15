class FollowsController < ApplicationController
  def create
    follower_user = current_user
    following_user = User.find(params[:followed_id])

    follow = Follow.new(follower: follower_user, following: following_user)

    respond_to do |format|
      if follow.save
        format.json do
          render json: { entries: render_to_string(partial: 'unfollow_button', formats: [:html],
                                                   locals: { user: following_user }) }
        end
      end
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    following_user = follow.following

    respond_to do |format|
      if follow.destroy
        format.json do
          render json: { entries: render_to_string(partial: 'follow_button', formats: [:html],
                                                   locals: { user: following_user }) }
        end
      end
    end
  end
end
