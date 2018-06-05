class User < ApplicationRecord
	# アクセス可能な属性を作成します。
	attr_accessor :remember_token

	# u1.errors.full_messages shows you error messages when it's not valid
	# Similarly u1.errors.messages shows you error messages in a hash format
	#      u1.errors.messages[:email] shows you an error message for 'email'
	# if it's not valid, you fail to save the User object

	# before save a user to DB, change email to lower case (callback)
	# in models, can omit 'self' in RHD (self.email.downcase <=> email.downcase)
	#           but cannot omit 'self' in LHS
	# following is same as before_save { self.email = email.downcase } (another way)
	before_save { email.downcase! }

	# If the last values are a hash (e.g. presence: true), no need to use brackets
	# validates :name, presence: true
	validates :name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: {with: VALID_EMAIL_REGEX},
					  uniqueness: { case_sensitive: false } # this understands 'uniqueness: true'

	# パスワードをハッシュ化する
	#
	# これにより、できるようになることは以下
	# 1) パスワードを、データベース内のpassword_digestという属性に保存できるようになる
	#    注意: has_secure_password機能を使えるようにするには、モデル内にpassword_digestという属性を足すこと。
	# 2) 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。
	#    また、存在性と値が一致するかどうかのバリデーションも追加される。
	# 3) authenticateメソッドが使えるようになる。
	#    (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
	#    !!user.authenticate(PSW) return true or false beacuse of '!!''
	#
	# need to update Gemfile (bcrypt is required)
	has_secure_password

	# need to check presence b/c it won't catch empty string ("") as < 6
	validates :password, presence: true, length: { minimum: 6 }

	# fixture向けのdigestメソッドを追加する
	# 渡された文字列のハッシュ値を返す
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	# ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
