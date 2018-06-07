class User < ApplicationRecord
	# アクセス可能な属性を作成
	attr_accessor :remember_token, :activation_token, :reset_token
	#attr_accessor :remember_token, :activation_token, :activated, :activated_at
  	before_create :create_activation_digest

	# u1.errors.full_messages shows you error messages when it's not valid
	# Similarly u1.errors.messages shows you error messages in a hash format
	#      u1.errors.messages[:email] shows you an error message for 'email'
	# if it's not valid, you fail to save the User object

	# before save a user to DB, change email to lower case (callback)
	# in models, can omit 'self' in RHD (self.email.downcase <=> email.downcase)
	#           but cannot omit 'self' in LHS
	# following is same as
	# before_save { self.email = email.downcase } (another way)
	# or before_save { email.downcase! }
	before_save   :downcase_email

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
	# has_secure_passwordではオブジェクト生成時に存在性を検証するようになっているため、
	# 空のパスワード (nil) が新規ユーザー登録時に有効になることはありません。
	# allow_nil: true は登録内容の更新時にパスワードを書かなくてもOKにする。
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

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

  	# トークンがダイジェストと一致したらtrueを返す
  	def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest") #self.send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
  	end

  	# ユーザーのログイン情報を破棄する
  	def forget
    	update_attribute(:remember_digest, nil)
  	end

  	# アカウントを有効にする
  	def activate
    	update_attribute(:activated,    true)
    	update_attribute(:activated_at, Time.zone.now)
  		#update_columns(activated: true, activated_at: Time.zone.now)
  	end

  	# 有効化用のメールを送信する
  	def send_activation_email
    	UserMailer.account_activation(self).deliver_now
  	end

  	# パスワード再設定の属性を設定する
  	def create_reset_digest
    	self.reset_token = User.new_token
    	#update_attribute(:reset_digest,  User.digest(reset_token))
    	#update_attribute(:reset_sent_at, Time.zone.now)
    	update_attributes(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  	end

  	# パスワード再設定のメールを送信する
  	def send_password_reset_email
    	UserMailer.password_reset(self).deliver_now
  	end

  	# パスワード再設定の期限が切れている場合はtrueを返す
  	def password_reset_expired?
  		#「パスワード再設定メールの送信時刻が、現在時刻より2時間以上前 (早い) の場合」
    	reset_sent_at < 2.hours.ago
  	end

  	private
  		# メールアドレスをすべて小文字にする
    	def downcase_email
      		#self.email = email.downcase
      		email.downcase!
    	end

    	# 有効化トークンとダイジェストを作成および代入する
    	def create_activation_digest
      		self.activation_token  = User.new_token
      		self.activation_digest = User.digest(activation_token)
    	end
end
