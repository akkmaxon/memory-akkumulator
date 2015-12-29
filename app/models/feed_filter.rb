class FeedFilter < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :hidden_category, class_name: "Category"
  validates :user_id, presence: true
  validates :hidden_category_id, presence: true
end
