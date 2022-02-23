class SessionsController < ApplicationController
  # POST /login
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:notice] = 'Incorrect username or password.'
      redirect_to '/login'
    end
  end
end
