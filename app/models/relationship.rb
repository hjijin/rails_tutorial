class Relationship < ActiveRecord::Base
  attr_accessible :followed_id # 与默认生成的 Relationship 模型不同，这里只有 followed_id 是可以访问的。

  # Rails 会通过 Symbol 获知外键的名字（例如，:follower 对应的外键是 follower_id，:followed 对应的外键是 followed_id），
  # 但 Followed 或 Follower 模型是不存在的，因此这里就要使用 User 这个类名
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
