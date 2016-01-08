require 'test_helper'

class FilterCategoriesControllerTest < ActionController::TestCase
  test "should get edit_filter_categories" do
    get :edit_filter_categories
    assert_response :success
  end

  test "should get update_filter_categories" do
    get :update_filter_categories
    assert_response :success
  end

end
