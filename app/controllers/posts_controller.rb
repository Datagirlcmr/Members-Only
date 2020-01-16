class PostsController < ApplicationController
  before_action :is_signed_in?, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to posts_index_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def is_signed_in?
    redirect_to posts_index_path if !signed_in?
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
