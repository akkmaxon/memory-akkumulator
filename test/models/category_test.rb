require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = categories(:one)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "title should not be empty" do
    @category.title = "   "
    assert_not @category.valid?
  end
end
