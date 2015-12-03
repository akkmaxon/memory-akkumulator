class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true
  
end
