require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)

    # このコードは慣習的に正しくない
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    #
    # おすすめではない表現
    # Micropost.create
    # Micropost.create!
    # Micropost.new
    #
    # いい表現 (紐付いているユーザーを通す)
    # user.microposts.create
    # user.microposts.create!
    # user.microposts.build   <- build instead of new
    #
    # こちらが習慣的に正しい
    # これらのメソッドは使うと、紐付いているユーザーを通してマイクロポストを作成することができます
    # 新規のマイクロポストがこの方法で作成される場合、user_idは自動的に正しい値に設定されます
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  # 初期テスト

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  # 時間逆順のテスト
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end