require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  def setup
    @article = articles(:one)
    log_in_as users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "article#article"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { content: @article.content, title: @article.title }, category: @article.category.title 
    end
    assert_equal "FirstCategory", Article.first.category.title
    assert_redirected_to category_path(assigns(:article).category)
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should not get edit article of other user" do
    get :edit, id: articles(:four)
    assert_redirected_to root_path
    assert_equal "Forbidden place", flash[:notice]
  end

  test "should update article" do
#   patch :update, id: @article, article: { content: @article.content, title: @article.title }
#    assert_redirected_to category_path(assigns(:article).category)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end
    assert_redirected_to articles_path
  end

  test "should not destroy article of other user" do
    assert_no_difference 'Article.count' do
      delete :destroy, id: articles(:four)
    end
    assert_redirected_to root_path
    assert_equal "Forbidden place", flash[:notice]
  end 
end
