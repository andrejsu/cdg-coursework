class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :authorize_post!
  after_action :verify_authorized

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to feed_posts_path, flash: { success: 'Post was created successfully!' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end

  def authorize_post!
    authorize(@post || Post)
  end
end
