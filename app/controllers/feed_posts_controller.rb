class FeedPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.followings.exists?
      @pagy, @posts = pagy Post.where(user_id: current_user.id).or(Post.where(user_id: current_user.followings.pluck(:id))).order(created_at: :desc)
    else
      @pagy, @posts = pagy Post.where(user_id: current_user.id)
    end
    @pagy_metadata = pagy_metadata(@pagy)

    respond_to do |format|
      format.html
      format.json {
        render json: { entries: render_to_string(partial: 'posts', formats: [:html]),
                                                 pagy: pagy_metadata(@pagy) }
      }
    end
  end

end
