class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password
  after_initialize :ensure_session_token

  has_many :checkpoints
  has_many(:comments, class_name: 'UserComment', foreign_key: :user_id, primary_key: :id)
  has_many(:self_comments, class_name: 'UserComment', foreign_key: :author_id, primary_key: :id)
  has_many(:goal_comments, class_name: 'GoalComment', foreign_key: :author_id, primary_key: :id)

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def correct_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user && user.correct_password?(password)
      return user
    end
    nil
  end
end
