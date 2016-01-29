require 'test_helper'

class WelcomeToAppControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should get welcome page" do
    sign_out users(:one)
    get :welcome
    assert_select 'a', count: 2
    assert_select 'input[value=?]', 'Try it in action'
  end

  test "should be redirected after login" do
    get :welcome
    assert_redirected_to articles_path
  end

end
