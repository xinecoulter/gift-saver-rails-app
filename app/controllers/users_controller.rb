class UsersController < ApplicationController
  # get '/users/new'
  def new
    @user = User.new
  end

  # post '/users'
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to "/", :notice => "You successfully created an account!"
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

  # put '/users/:username'
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

  # delete '/users/:username'
  def destroy
    user = User.where(username: params[:username]).first
    user.destroy
    redirect_to "/"
  end
end