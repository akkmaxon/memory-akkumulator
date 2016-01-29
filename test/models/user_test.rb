require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "user@email.com",
		     password: 'password',
		     password_confirmation: 'password')
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "email should not be empty" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should be unique" do
    other_user = @user.dup
    other_user.email.upcase!
    @user.save
    assert_not other_user.valid?
  end

  test "password should not be empty" do
    @user.password = @user.password_confirmation = ' ' * 10
    assert_not @user.valid?
  end
  
  test "password's length 8 at least" do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end

  test "associated articles should be destroyed" do
    user = users(:one)
    assert_difference 'Article.count', -2 do
      user.destroy
    end
  end

  test "associated relationships should be destroyed" do
    user = users(:one)
    user.relationships.create hidden_category_id: Category.first.id
    assert_difference 'FeedFilter.count', -1 do
      user.destroy
    end
  end
end
