class GiftsController < ApplicationController
  require 'amazon/aws/search'
  include Amazon::AWS
  include Amazon::AWS::Search

  # get '/users/:username/gifts'
  def search
    @user = User.where(username: params[:username]).first
    @categories = %w( All Apparel Automotive Baby Beauty Blended Books Classical DigitalMusic DVD Electronics ForeignBooks GourmetFood Grocery HealthPersonalCare Hobbies HomeGarden HomeImprovement Industrial Jewelry KindleStore Kitchen Lighting Magazines Merchants Miscellaneous MP3Downloads Music MusicalInstruments MusicTracks OfficeProducts OutdoorLiving Outlet PCHardware PetSupplies Photo Shoes SilverMerchants Software SoftwareVideoGames SportingGoods Tools Toys UnboxVideo VHS Video VideoGames Watches Wireless WirelessAccessories )
    render "new"
  end

  # get '/users/:username/gifts/new' => 'gifts#new'
  def new
    @categories = %w( All Apparel Automotive Baby Beauty Blended Books Classical DigitalMusic DVD Electronics ForeignBooks GourmetFood Grocery HealthPersonalCare Hobbies HomeGarden HomeImprovement Industrial Jewelry KindleStore Kitchen Lighting Magazines Merchants Miscellaneous MP3Downloads Music MusicalInstruments MusicTracks OfficeProducts OutdoorLiving Outlet PCHardware PetSupplies Photo Shoes SilverMerchants Software SoftwareVideoGames SportingGoods Tools Toys UnboxVideo VHS Video VideoGames Watches Wireless WirelessAccessories )
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

  # Retrieves image_url for aws_show action
  def get_image_url(result)
    if result.image_sets.image_set.length == 1
      image_url = result.image_sets.image_set.medium_image.url
    else
      image_url = "http://askmissa.com/wp-content/uploads/2008/11/unavailable.gif"
    end
    return image_url
  end

  # Retrieves price for aws_show action
  def get_price(result)
    if result.item_attributes.list_price
      price = result.item_attributes.list_price.formatted_price
    else
      price = "whoops"
    end
    return price
  end

  # Retrieves url for aws_show action
  def get_url(result)
    url = nil
    result.item_links.item_link.to_s.split("\n").each do |line|
      if line.include? "url"
        num = "url = ".length
        url = line[num..line.length]
      end
      break unless url.nil?
    end
    if url.nil?
      url = "n/a"
    end
    return url
  end

  # get '/users/:username/gifts/search/:asin'
  # asin is product id number
  def aws_show
    @user = User.where(username: params[:username]).first
    item_search = ItemSearch.new('All', { 'Keywords' => params[:asin] })
    response_group = ResponseGroup.new( 'Medium' )
    request = Request.new
    results = request.search(item_search, response_group)
    @result = results.item_search_response[0].items[0].item[0]
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
end