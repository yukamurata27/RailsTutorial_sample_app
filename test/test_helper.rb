require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# make colors change
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Allows to use Application helper in teh test environment
  # Now you can use the 'full_title' helper in site_layout_test.rb
  include ApplicationHelper
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end