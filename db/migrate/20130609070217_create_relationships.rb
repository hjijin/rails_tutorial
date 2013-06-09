class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.timestamps
    end

    add_index :relationships, :follower_id # 通过 follower_id 和 followed_id 来查找用户之间的关系，考虑到性能，要为这两列加上索引
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
    # 组合索引（composite index），其目的是确保 (follower_id, followed_id) 组合是唯一的，这样用户就无法多次关注同一个用户了
  end
end
