class Category < ActiveRecord::Base
  belongs_to :user
  has_many :articles, dependent: :destroy
  validates :title, presence: true
end
