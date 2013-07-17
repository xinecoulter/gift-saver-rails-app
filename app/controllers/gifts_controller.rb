class GiftsController < ApplicationController
  require 'amazon/aws/search'
  include Amazon::AWS
  include Amazon::AWS::Search

  # get '/users/:username/gifts'
  def search
    @user = User.where(username: params[:username]).first
    render "new"
  end

  # get '/users/:username/gifts/new' => 'gifts#new'
  def new
    @user = User.where(username: params[:username]).first
    if params[:name]
      @results = params[:name]
    else
      @results = nil
    end
  end
end