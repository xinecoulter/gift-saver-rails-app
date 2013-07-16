class User < ActiveRecord::Base
  has_many :recipients
  has_many :gifts

  attr_accessible :first_name, :last_name, :email, :username, :password

  # validates :first_name, :last_name, :email, :username, :password, presence: true
  # validates :email, :username, uniqueness: true
  # validates :first_name, :last_name, length: { minimum: 2 }
  # validates :username, length: { in: 6..10 }
  # validates :password, length: { in: 6..20 }
end