module GiftsHelper
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
    if result.item_links.item_link[0]
      url = result.item_links.item_link[0].url
    else
      url = "n/a"
    end
    return url
  end

  # Changes rating of potential gift
  def change_rating(params)
    case params
    when "up"
      if @gift.rating <10
        @gift.rating += 1
      end
    when "down"
      if @gift.rating >0
        @gift.rating -= 1
      end
    end
  end
end