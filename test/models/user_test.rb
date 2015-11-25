require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Name",
    		     email: "user@email.com",
		     password: "Password",
		     password_confirmation: "Password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 50
    assert_not @user.valid?
  end
  
  test "name should not be empty" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  test "email should not be empty" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email with good format" do
    valid = %w{ my@email.Co ex1@Aa.bz _who@here.cn a+bb@LOOK.ru akk.maxon@goog.le }
    valid.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "email with wrong format" do
    invalid = %w{ my@in,val wrong_at_email.com user.ex@mail foo@la_la.cc foo@la+la.com }
    invalid.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    clone = @user.dup
    clone.email.upcase!
    @user.save
    assert_not clone.valid?
  end

  test "save email in downcase" do
    email = "My@EmAil.ru"
    @user.email = email
    @user.save
    @user.reload
    assert_not @user.email == email
  end

  test "password should not be empty" do
    @user.password = @user.password_confirmation = "      "
    assert_not @user.valid?
  end

  test "password should not be short" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
