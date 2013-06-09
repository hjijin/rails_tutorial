class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at] # 为 user_id 和 created_at 列加入了索引, 因为我设想要按照发布时间的倒序查询某个用户所有的微博
  end
end
