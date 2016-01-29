require 'test_helper'

class HiddenCategoriesUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
  end

  test "user should add category to hidden_categories" do
    assert @user.hidden_categories.empty?
    @user.relationships.create hidden_category_id: @user.articles.first.category.id
    assert_not @user.hidden_categories.empty?
  end
end
