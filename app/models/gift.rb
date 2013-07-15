class Gift < ActiveRecord::Base
  has_and_belongs_to_many :recipients

  attr_accessible :name, :image, :category, :price, :rating, :url
end