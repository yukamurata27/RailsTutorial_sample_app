class RelationshipsController < ApplicationController
	before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # Way 1 (Ajax)
    # リクエストの種類によって応答を場合分けするときは、respond_toメソッドというメソッドを使います
    # ブロック内のコードのうち、いずれかの1行が実行される(上から順に実行する逐次処理)
    # respond_to do |format|
    #   format.html { redirect_to user }
    #   format.js
    # end
    #
    # Way 2 (redirect)
    # redirect_to user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    #redirect_to user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
