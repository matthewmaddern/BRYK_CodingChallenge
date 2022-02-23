class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    return if current_user

    flash[:notice] = 'You must be authenticated to view that page.'
    redirect_to login_path
  end
end
