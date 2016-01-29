require 'test_helper'

class FilterCategoriesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should post update_filter_categories" do
    post :update_filter_categories, params: {:"1_category" => '1' } 
    assert_equal 'Filter was updated.', flash[:notice]
  end

end
