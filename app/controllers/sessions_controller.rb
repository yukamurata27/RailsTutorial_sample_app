class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # *ユーザーログイン後にユーザー情報のページにリダイレクトする
      #log_in @user
      # *ログインしたユーザーを記憶する処理
      #params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # *following is same as user_url(user)
      #redirect_back_or @user

      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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
    log_out if logged_in?
    redirect_to root_url
  end
end