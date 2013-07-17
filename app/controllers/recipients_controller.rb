class RecipientsController < ApplicationController
  # get '/users/:username/recipients/new'
  def new
    @user = User.where(username: params[:username]).first
  end

  # post '/users/:username/recipients'
  def create
    @user = User.where(username: params[:username]).first
    @recipient = Recipient.new(name: params[:name], birthday: params[:birthday])
    if @recipient.save
      @user.recipients << @recipient
      redirect_to "/users/#{@user.username}"
    else
      render action: "new"
    end
  end

  # get '/users/:username/recipients/:id'
  def show
    @user = User.where(username: params[:username]).first
    require 'date'
    @recipient = Recipient.find(params[:id])
    if @recipient.birthday?
      birthday = Date.new(Date.today.year, @recipient.birthday.month, @recipient.birthday.day)
      birthday += 1.year if Date.today >= birthday
      @time_until_next_birthday = (birthday - DateTime.now).to_i
    end
  end

  # get '/users/:username/recipients/:id/edit'
  def edit
    @user = User.where(username: params[:username]).first
    @recipient = Recipient.find(params[:id])
  end

  # put '/users/:username/recipients/:id'
  def update
    @user = User.where(username: params[:username]).first
    @recipient = Recipient.find(params[:id])
    @recipient.name = params[:name]
    @recipient.birthday = params[:birthday]
    if @recipient.save
      redirect_to "/users/#{@user.username}/recipients/#{@recipient.id}"
    else
      render action: "edit"
    end
  end

  # delete '/users/:username/recipients/:id'
  def destroy
    user = User.where(username: params[:username]).first
    recipient = Recipient.find(params[:id])
    recipient.destroy
    redirect_to "/users/#{user.username}"
  end
end