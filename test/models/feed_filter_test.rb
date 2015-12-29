require 'test_helper'

class FeedFilterTest < ActiveSupport::TestCase
  
  def setup
    @relationship = FeedFilter.new(user_id: 1, hidden_category_id: 1)
  end

  test "always valid" do
    assert @relationship.valid?
  end

  test "should require user_id" do
    @relationship.user_id = nil
    assert_not @relationship.valid?
  end

  test "should require hidden_category" do
    @relationship.hidden_category_id = nil
    assert_not @relationship.valid?
  end
end
