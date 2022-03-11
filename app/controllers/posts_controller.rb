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

  def like
    @post = Post.find(params[:id])
    if current_user.voted_up_on? @post
      @post.unliked_by current_user
    else
      @post.liked_by current_user
    end
    render 'like.js.erb'
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
