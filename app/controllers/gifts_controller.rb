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
      item_search = ItemSearch.new(params[:category], { 'Keywords' => params[:name] })
      response_group = ResponseGroup.new( 'Medium' )
      request = Request.new
      results = request.search(item_search, response_group)
      @results = results.item_search_response[0].items[0].item[0..9]
    else
      @results = nil
    end
  end
end

# is = ItemSearch.new( 'Books', { 'Title' => 'Ruby' } )
# rg = ResponseGroup.new( 'Small' )
# req = Request.new
# resp = req.search( is, rg )
# items = resp.item_search_response[0].items[0].item THIS IS AN ARRAY OF ITEMS RETURNED
# resp.item_search_response[0].items[0].item[0].asin