class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles, dependent: :destroy
  has_many :relationships, {
    class_name: "FeedFilter",
    foreign_key: "user_id",
    dependent: :destroy
  }
  has_many :hidden_categories, {
    through: :relationships,
    source: :hidden_category
  }

end
