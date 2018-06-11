class Relationship < ApplicationRecord
  # explicitly write dow the class name (class_name: "User") with the key name (:follower/:followed)
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # validation
  # 以前のRailsのバージョンでは、このバリデーションが必須でしたが、Rails 5から必須ではなくなりました
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end