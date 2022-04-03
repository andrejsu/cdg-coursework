class FeedPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @posts = pagy Post.where(user_id: current_user.id)
                             .or(Post.where(user_id: current_user.followings.pluck(:id)))
                             .includes(:user, :likes)
                             .order(created_at: :desc)
    @pagy_metadata = pagy_metadata(@pagy)

    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: 'posts', formats: [:html]),
                       pagy: pagy_metadata(@pagy) }
      end
    end
  end
end
