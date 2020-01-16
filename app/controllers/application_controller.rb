class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper :all

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end
  helper_method :signed_in?

  def remember(user)
    user.remember_token_generator
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
