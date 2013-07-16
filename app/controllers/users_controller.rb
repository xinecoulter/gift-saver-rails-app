class UsersController < ApplicationController
  def new
  end

  def index
    @user = User.where(username: params[:username]).first
    @recipients = @user.recipients
  end
end