require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  def setup
    @article = articles(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "article.article"
    assert_select 'a', text: 'Reload'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'form#new_article', count: 1
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { content: @article.content, title: @article.title }, category: @article.category.title 
    end
    assert_equal "FirstCategory", Article.first.category.title
    flash[:notice] = 'Article was successfully created.'
    assert_redirected_to category_path(assigns(:article).category)
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
    assert_select 'form.edit_article', count: 1
  end

  test "should not get edit article of other user" do
    get :edit, id: articles(:four)
    assert_redirected_to articles_path
    assert_equal "Forbidden place", flash[:alert]
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
    assert_redirected_to articles_path
    assert_equal "Forbidden place", flash[:alert]
  end 

  test "search with blank string" do
    get :search, search: "     "
    assert_equal 'Your search query is empty', flash[:alert]
  end

  test "should get search and return proper results" do
    get :search, search: "Article"
    assert_select "article.article", count: 2
  end
end
