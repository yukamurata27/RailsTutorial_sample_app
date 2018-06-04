require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # Test for invalid information
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end

    # Check not 'routes' but 'template' (HTML)
    assert_template 'users/new'

    assert_select 'div#error_explanation'
    assert_select 'div.alert'

    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end

    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド
    follow_redirect!

    assert_template 'users/show'

    assert_not flash.empty?

    assert is_logged_in?
  end
end