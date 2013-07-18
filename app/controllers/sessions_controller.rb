class SessionsController < ApplicationController
  def new
  end

  def create
    # The following returns t/f
    user = User.authenticate(params[:username], params[:password])
    if user
      # This is if login worked
      # Stores the user_id in a cookie
      session[:user_id] = user.id
      redirect_to "/users/#{user.username}", notice: "Signed in"
    else
      # This is if login didn't work
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  # Logs user out
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end
end