require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    @user = users(:one)
  end

  test "should not show category" do
    get :show, id: @category
    assert_redirected_to login_url
  end
  
  test "should show category" do
    log_in_as @user
    get :show, id: @category
    assert_response :success
  end

  test "should not get edit" do
    get :edit, id: @category
    assert_redirected_to login_url
  end

  test "should get edit" do
    log_in_as @user
    get :edit, id: @category
    assert_response :success
  end

  test "should not update category" do
    patch :update, id: @category, category: { title: @category.title }
    assert_redirected_to login_url
  end

  test "should update category" do
    log_in_as @user
    patch :update, id: @category, category: { title: @category.title }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should not destroy category" do
    assert_no_difference 'Category.count' do
      delete :destroy, id: @category
    end
  end

  test "should destroy category" do
    log_in_as @user
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end
  end
end
