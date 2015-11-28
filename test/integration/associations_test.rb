require 'test_helper'

class AssociationsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @article = articles(:one)
    @category = categories(:one)
  end

  test "user - article associations should be good" do
    assert_equal 3, @user.articles.count
    assert @user.articles.find_by(title: "FirstArticle")
    assert_not @user.articles.find_by(title: "FourthArticle")
    assert_equal "FirstUser", @article.user.name
  end

  test "user - category associations" do
    assert_equal 2, @user.categories.count
    assert @user.categories.find_by(title: "SecondCategory")
    assert_equal "FirstUser", @category.user.name
  end

  test "article - category associations" do
    assert_equal 2, @category.articles.count
    assert_equal "MyTextOfFirstArticle", @category.articles.find_by(title: "FirstArticle").content
    assert_equal "FirstCategory", @article.category.title
  end 
end
