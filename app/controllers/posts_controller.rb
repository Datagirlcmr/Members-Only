class PostsController < ApplicationController
  before_action :is_signed_in?, only: [:new, :create]

  def new
    @post = Post.new()
  end

  def create
    post = Post.new(title: params[:post][:title], body: params[:post][:body], user_id: current_user.id)
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
end
