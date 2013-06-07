class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_token, :string
    add_index :users, :remember_token # 因为要使用remember_token取回用户，所以我们为 remember_token 列加了索引
  end
end
