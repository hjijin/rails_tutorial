class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true 
  	# 上述代码调用了 Rails 中的 add_index 方法，为 users 表的 email 列建立索引。
  	# 索引本身并不能保证唯一性，所以还要指定 unique: true。
  end
end
