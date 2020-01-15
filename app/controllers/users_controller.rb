class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    if user.save
      sign_in(user)
      redirect_to posts_index_path
    else
      render 'new'
    end
  end

  def show
  end
end
