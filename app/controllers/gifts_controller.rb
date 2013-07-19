class GiftsController < ApplicationController
  require 'amazon/aws/search'
  include Amazon::AWS
  include Amazon::AWS::Search
  include GiftsHelper

  @@categories = %w( All Apparel Automotive Baby Beauty Blended Books Classical DigitalMusic DVD Electronics ForeignBooks GourmetFood Grocery HealthPersonalCare Hobbies HomeGarden HomeImprovement Industrial Jewelry KindleStore Kitchen Lighting Magazines Merchants Miscellaneous MP3Downloads Music MusicalInstruments MusicTracks OfficeProducts OutdoorLiving Outlet PCHardware PetSupplies Photo Shoes SilverMerchants Software SoftwareVideoGames SportingGoods Tools Toys UnboxVideo VHS Video VideoGames Watches Wireless WirelessAccessories )

  # get '/users/:username/gifts'
  def search
    @user = User.where(username: params[:username]).first
    @categories = @@categories
    render "new"
  end

  # get '/users/:username/gifts/new' => 'gifts#new'
  def new
    @categories = @@categories
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

  # get '/users/:username/gifts/search/:asin'
  # asin is product id number
  # shows amazon product not saved to database
  def aws_show
    @user = User.where(username: params[:username]).first
    item_lookup = ItemLookup.new( 'ASIN', { 'ItemId' => params[:asin], 'MerchantId' => 'Amazon' } )
    response_group = ResponseGroup.new( 'Medium' )
    request = Request.new
    results = request.search( item_lookup, response_group )
    @result = results.item_lookup_response[0].items.item
    @image_url = get_image_url(@result)
    @price = get_price(@result)
    @url = get_url(@result)
  end

  # post '/users/:username/gifts'
  def create
    @user = User.where(username: params[:username]).first
    @gift = Gift.new(name: params[:name], category: params[:category], image: params[:image], price: params[:price], url: params[:url], rating: 5)
    @gift.save
    @user.gifts << @gift
    if params[:recipient_id] == "none"
      redirect_to "/users/#{@user.username}"
    else
      recipient = Recipient.find(params[:recipient_id])
      recipient.gifts << @gift
      redirect_to "/users/#{@user.username}/recipients/#{recipient.id}"
    end
  end

  # get '/users/:username/gifts/:id'
  # shows amazon product already saved to database
  def show
    @user = User.where(username: params[:username]).first
    @gift = Gift.find(params[:id])
    if @gift.recipient_id
      @recipient = Recipient.find(@gift.recipient_id)
    else
      @recipient = nil
    end
  end

  # post '/users/:username/gifts/:id'
  def edit
    @user = User.where(username: params[:username]).first
    @gift = Gift.find(params[:id])
    if @gift.recipient_id
      @recipient = Recipient.find(@gift.recipient_id)
    else
      @recipient = nil
    end

    change_rating(params[:rating])

    @gift.save
    render "show"
  end

  # put '/users/:username/gifts/:id'
  def update
    user = User.where(username: params[:username]).first
    gift = Gift.find(params[:id])
    gift.recipient_id = params[:new_recipient_id]
    gift.save
    redirect_to "/users/#{user.username}/gifts/#{gift.id}"
  end

  # delete '/users/:username/gifts/:id'
  def destroy
    user = User.where(username: params[:username]).first
    gift = Gift.find(params[:id])
    gift.destroy
    redirect_to "/users/#{user.username}"
  end
end