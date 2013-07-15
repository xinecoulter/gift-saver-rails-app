class Recipient < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :gifts

  attr_accessible :name, :birthday

  validates :name, presence: true
  validates :name, length: { minimum: 2 }
end