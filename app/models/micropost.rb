class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    # followed_user_ids = user.followed_user_ids
    # where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    # followed_user_ids 方法是 Active Record 根据 has_many :followed_users 关联合成的，
    # 这样只需在关联名的后面加上 _ids 就可以获取 user.followed_users 集合中所有用户的 id (user.followed_users.map(&:id))了。

    # 跟上面的等效
    # followed_user_ids = user.followed_user_ids
    # where("user_id IN (:followed_user_ids) OR user_id = :user_id",
    #       followed_user_ids: followed_user_ids, user_id: user)

		followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
