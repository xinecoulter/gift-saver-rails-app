class RecipientsController < ApplicationController
  # get '/users/:username/recipients/new'
  def new
  end

  # get '/users/:username/recipients/:id'
  def show
    require 'date'
    @recipient = Recipient.find(params[:id])
    birthday = Date.new(Date.today.year, @recipient.birthday.month, @recipient.birthday.day)
    birthday += 1.year if Date.today >= birthday
    @time_until_next_birthday = (birthday - DateTime.now).to_i
  end
end