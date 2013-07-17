class User < ActiveRecord::Base
  # Allows for mass assignment
  attr_accessible :first_name, :last_name, :email, :username, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  has_many :recipients
  has_many :gifts

  # For validation
  validates :password, confirmation: :true
  validates :password, presence: true, on: :create
  validates :first_name, :last_name, :email, :username, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :username, length: { in: 6..15 }
  validates :password, length: { in: 6..20 }

  def encrypt_password
    if password.present?
      # Generates a random string that helps to encrypt the password
      self.password_salt = BCrypt::Engine.generate_salt

      # Encrypts the password, using the salt that was just created
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(username, password)
    # Authenticates a user
    user = User.find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end