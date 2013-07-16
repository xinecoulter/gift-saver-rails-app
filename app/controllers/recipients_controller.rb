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
    require 'date'
    @recipient = Recipient.find(params[:id])
    if @recipient.birthday?
      birthday = Date.new(Date.today.year, @recipient.birthday.month, @recipient.birthday.day)
      birthday += 1.year if Date.today >= birthday
      @time_until_next_birthday = (birthday - DateTime.now).to_i
    end
  end
end