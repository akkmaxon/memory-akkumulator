require 'test_helper'

class RenderPagesTest < ActionDispatch::IntegrationTest

   test "home page if not logged in" do
     get root_path
     assert_redirected_to login_url
     follow_redirect!
     assert_select 'header a', text: "Add article", count: 0
     assert_select 'footer input', count: 0
     assert_select 'a', text: "new user?"
   end

end
