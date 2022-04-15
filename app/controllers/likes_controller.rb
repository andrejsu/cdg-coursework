class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)

    respond_to do |format|
      if @like.save
        format.json do
          render json: { entries: render_to_string(partial: 'dislike_button', formats: [:html],
                                                   locals: { like: @like }) }
        end
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @likeable = @like.likeable

    respond_to do |format|
      if @like.destroy
        format.json do
          render json: { entries: render_to_string(partial: 'like_button', formats: [:html],
                                                   locals: { likeable: @likeable }) }
        end
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
