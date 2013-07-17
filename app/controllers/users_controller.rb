class UsersController < ApplicationController
  # get '/users/new'
  def new
  end

  # post '/users'
  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], username: params[:username], password: params[:password])
    if @user.save
      redirect_to "/users/#{@user.username}"
    else
      render action: "new"
    end
  end

  # get '/users/:username'
  def show
    @user = User.where(username: params[:username]).first
    @recipients = @user.recipients
  end

  # get '/users/:username/edit'
  def edit
    @user = User.where(username: params[:username]).first
  end

  def update
    @user = User.where(username: params[:username]).first
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      redirect_to "/users/#{@user.username}"
    else
      render action: "edit"
    end
  end
end