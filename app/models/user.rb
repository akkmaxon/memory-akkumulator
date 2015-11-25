class User < ActiveRecord::Base
 before_save :email_downcase
  validates :name, {
    presence: true,
    length: { maximum: 49 }
  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {
    presence: true,
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  }
  has_secure_password
  validates :password, {
    presence: true,
    length: { minimum: 6 },
    allow_nil: true
  }

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  private

  def email_downcase
    email.downcase!
  end
end
