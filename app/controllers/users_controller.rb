class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], username: params[:username], password: params[:password])
    if @user.save
      redirect_to "/users/#{@user.username}"
    else
      render action: "new"
    end
  end

  def index
    @user = User.where(username: params[:username]).first
    @recipients = @user.recipients
  end
end