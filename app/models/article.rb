class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  default_scope -> { order(updated_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true
  
end
