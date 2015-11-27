require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  def setup
    @article = articles(:one)
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should not be empty" do
    @article.title = "   "
    assert_not @article.valid?
  end

  test "content should not be empty" do
    @article.content = "   "
    assert_not @article.valid?
  end

  test "user's association should be valid" do
    assert_equal "FirstUser", @article.user.name
  end
end
