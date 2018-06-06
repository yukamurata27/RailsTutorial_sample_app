class UsersController < ApplicationController

  # only logged in user can go to 'edit' and 'update' actions in controller
  # see private section for the definitions of logged_in_user and correct_user
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # only admin_user has an access to destroy action
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
  	# :id is obtained from route (users/1)
  	@user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?

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
  	# but it can be actually used as 'symbols' (e.g. params[:user])
    #
    # This is volnerable. Causes an error
    #@user = User.new(params[:user])
    #
    # so use the following instead
    @user = User.new(user_params)
    if @user.save
      # * ログインの主な流れ
      # * user id からセッションを作る
      # * flash表示の準備
      # * userのページへリダイレクト

      #log_in @user
      
      # * 登録完了後に表示されるページにメッセージを表示し (この場合は新規ユーザーへのウェルカムメッセージ)
      # * 2度目以降にはそのページにメッセージを表示しないようにする
      # * flash変数に代入したメッセージは、リダイレクトした直後のページで表示できる
      #
      # * Bootstrap CSSはflashのクラス用に4つのスタイルを持っています (success、info、warning、danger)
      #
      #flash[:success] = "Welcome to the Sample App!"

      # * same as 'redirect_to user_url(@user)'
      #redirect_to @user

      # refactoring
      # change
      # UserMailer.account_activation(@user).deliver_now
      # to
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    # use correct_user instead of
    # @user = User.find(params[:id])
  end

  def update
    # use correct_user instead of 
    # @user = User.find(params[:id])
    #
    # user_params can be used only in controller (= params[:user] called strong parameters)
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  	# protection when using a new model from a form
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
      # instead of the above, do the following (using current_user?(user) in sessions_helper
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
