require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # Applicationヘルパーを読み込んだことでfull_titleヘルパーが利用できる
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    # h1タグの内側にある、gravatarクラス付きのimgタグがあるかどうかをチェックできます
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    assert_select 'strong#following'
    assert_match @user.following.count.to_s, response.body
    assert_select 'strong#followers'
    assert_match @user.followers.count.to_s, response.body
  end
end