class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      # following is same as user_url(user)
      redirect_to user
    else
      # flashではなくてflash.nowを使うとフラッシュが消える
      flash.now[:danger] = 'Invalid email/password combination'
      # /sessions/new
  	  # newビューが出力される
      # エラーメッセージを作成する
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end