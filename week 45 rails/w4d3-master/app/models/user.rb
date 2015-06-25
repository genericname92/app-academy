class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats
  has_many :cat_rental_requests

  def reset_session_token!
    self.session_token = User.create_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.create_session_token
  end

  def self.create_session_token
    SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    return if password.nil?
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(user_name, password)
    user = self.find_by(user_name: user_name)
    user && user.is_password?(password) ? user : nil
  end
end
