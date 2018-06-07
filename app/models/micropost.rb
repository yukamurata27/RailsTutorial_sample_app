class Micropost < ApplicationRecord
  # rails generate model Micropost content:text user:references -(1)

  # DB Data Model
  # id           int
  # content*     text
  # user_id*     integer
  # created_at   datetime
  # updated_at   datetime
  # *'s are the ones added

  # user:referencesという引数も含めていたから
  # ユーザーと１対１の関係であることを表すbelongs_toのコードも追加されています
  #
  # references型を利用すると(1)、
  # 自動的にインデックスと外部キー参照付きのuser_idカラムが追加され、
  # UserとMicropostを関連付けする下準備をしてくれます
  #
  # Userモデルの方では、has_many :micropostsと追加する必要があります
  belongs_to :user

  # default scope #
  # 特定の順序にしたい場合は、default_scopeの引数にorderを与えます
  # 順序を逆にしたい場合は、次のように生のSQLを引数に与える必要があります
  # order('created_at DESC')
  # Rails 4.0からは次のようにRubyの文法でも書けるようになりました
  #
  # ->というラムダ式
  # callメソッドが呼ばれたとき、ブロック内の処理を評価します
  default_scope -> { order(created_at: :desc) }

  # CarrierWaveに画像と関連付けたモデルを伝えるためには、
  # mount_uploaderというメソッドを使います
  #
  # このメソッドは、引数に(db)属性名のシンボルと生成されたアップローダーのクラス名を取ります
  mount_uploader :picture, PictureUploader

  # validatesは属性名を引数に取る
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # validates ではなく validate
  # validateメソッドでは、引数にシンボルを取り、そのシンボル名に対応したメソッドを呼び出す
  validate  :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
      	# カスタマイズしたエラーメッセージをerrorsコレクションに追加しています
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
