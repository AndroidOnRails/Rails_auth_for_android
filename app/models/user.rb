class User < ActiveRecord::Base
  attr_accessible :username, :email, :password_salt, :password_hash, :password
  attr_accessor :password

  validates :email, :uniqueness => true

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  		user
  	else
      user = find_by_username email
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
    		nil
      end
    end
  end

  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

end
