# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation 
  # 使用 attr_accessible 可以避免 mass assignment 漏洞，这是 Rails 应用程序最常见的安全漏洞之一

  has_secure_password
  # Rails 中已经集成 has_secure_password,  验证 password 和 password_confirmation 是否相等；
	# 定义 authenticate 方法，对比加密后的密码和 password_digest 是否一致，验证用户的身份。

  before_save { |user| user.email = email.downcase } 
  # before_save { self.email.downcase! } # before_save 回调函数的另一种写法
  # 存入数据库之前把 Email 地址转换成全小写字母的形式，因为不是所有数据库适配器的索引都是区分大小写的。

  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # Ruby 中的常量都是以大写字母开头的。

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # 把 true 换成了 {case_sensitive: false}，Rails 会自动指定 :uniqueness 的值为 true。
  # 唯一性验证的不足：
		# 现在还有一个小问题，在此衷心的提醒你：唯一性验证无法真正保证唯一性。
		#   Alice 用 alice@wonderland.com 注册；
		#   Alice 不小心按了两次提交按钮，连续发送了两次请求；
		#   然后就会发生下面的事情：请求 1 在内存中新建了一个用户对象，通过验证；请求 2 也一样。请求 1 创建的用户存入了数据库，请求 2 创建的用户也存入了数据库。
		#   结果是，尽管有唯一性验证，数据库中还是有两条用户记录的 Email 地址是一样的。

		# 上面这种难以置信的过程是可能会发生的，只要有一定的访问量，在任何 Rails 网站中都可能发生。
		# 幸好解决的办法很容易实现，只需在数据库层也加上唯一性限制。我们要做的是在数据库中为 email 列建立索引，然后为索引加上唯一性限制。
  private
    # 只会在 User 模型内部使用的方法，没必要把它开放给用户之外的对象。在 Ruby 中，可以使用 private 关键字限制方法的可见性
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
      # 如果不指定 self 的话，只是创建了一个名为 remember_token 的局部变量， 
      # 加上 self 之后，赋值操作就会把值赋值给用户的 remember_token 属性，保存用户时，随着其他的属性一起存入数据库。
      # Ruby 标准库中 SecureRandom 模块提供的 urlsafe_base64 方法来生成随机字符串
      # urlsafe_base64 方法生成的是 Base64 字符串
    end
end
