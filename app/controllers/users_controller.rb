class UsersController < ApplicationController
  def show
  	# :id is obtained from route (users/1)
  	@user = User.find(params[:id])

  	# another way to debug
  	# byebug gem allows to use 'debugger' method
  	# ddebug console is now available on server window
  	# (byebug) @user.name
	# "Example User"
  	# (byebug) puts params.to_yaml
  	# ...
  	#
  	#debugger
  end

  def new
  	# debugger
  	@user = User.new
  end

  def create
  	# In debugging 'params' looks like a collection of string,
  	# but it can actually be used as 'symbols' (e.g. params[:user])
    #
    # This is volnerable. Causes an error
    #@user = User.new(params[:user])
    #
    # so use the following instead
    @user = User.new(user_params)
    if @user.save
      # 登録完了後に表示されるページにメッセージを表示し (この場合は新規ユーザーへのウェルカムメッセージ)
      # 2度目以降にはそのページにメッセージを表示しないようにする
      # flash変数に代入したメッセージは、リダイレクトした直後のページで表示できる
      #
      # Bootstrap CSSはflashのクラス用に4つのスタイルを持っています (success、info、warning、danger)
      #
      ### currently not working ###
      flash[:success] = "Welcome to the Sample App!"

      # same as 'redirect_to user_url(@user)'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  	# protection when using a new model from a form
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
