class SessionsController < ApplicationController
  def new
    session = {}
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      remember user
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to users_new_path
  end
end
