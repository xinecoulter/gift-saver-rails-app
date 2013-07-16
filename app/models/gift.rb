class Gift < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient

  attr_accessible :name, :image, :category, :price, :rating, :url
end