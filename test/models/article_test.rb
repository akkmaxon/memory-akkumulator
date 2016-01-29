require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  def setup
    @first = articles(:one)
    @second = articles(:two)
  end

  test "should be valid" do
    assert @first.valid?
  end

  test "title should not be empty" do
    @first.title = "   "
    assert_not @first.valid?
  end

  test "content should not be empty" do
    @first.content = "   "
    assert_not @first.valid?
  end

  test "order is desc" do
    first = Article.create(title: 'New article',
			   content: 'Content of new article')
    assert_equal 'New article', Article.first.title
  end

end
