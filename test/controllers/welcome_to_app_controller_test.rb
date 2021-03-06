require 'test_helper'

class WelcomeToAppControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should get welcome page" do
    sign_out users(:one)
    get :welcome
    assert_select 'input[value=?]', 'How is it?'
  end

  test "should be redirected after login" do
    get :welcome
    assert_redirected_to articles_path
  end

end
