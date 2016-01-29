ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as user, options = {}
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '0'
    post user_session_path, user: {
      email: user.email,
      password: password,
      remember_me: remember_me
    }
  end
end
