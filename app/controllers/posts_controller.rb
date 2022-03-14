class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :like]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path, flash: { success: "Post was created successfully!" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
