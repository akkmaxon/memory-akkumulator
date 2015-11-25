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

  private

  def email_downcase
    email.downcase!
  end
end
