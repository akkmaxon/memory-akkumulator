require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    name = "NewUser"
    email = "new@email.com"
    assert_no_difference 'User.count' do
      post :create, user: { name: '', 
      			    email: 'my@bad', 
			    password: 'pass', 
			    password_confirmation: 'word' }
      end
    assert_template :new
    assert_difference 'User.count', 1 do
      post :create, user: { name: name, 
      			    email: email, 
      			    password: "password", 
      			    password_confirmation: "password" }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user without password" do
    new_email = "new@email.com"
    patch :update, id: @user, user: { email: new_email, name: @user.name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should update user with password" do
    new_email = "new@email.com"
    patch :update, id: @user, user: { email: new_email, 
    				      name: @user.name,
				      password: 'password',
				      password_confirmation: 'password' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
