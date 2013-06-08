module SessionsHelper
	def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    # 代码中用到的 cookies 方法是由 Rails 提供的，可以把它看成 Hash，其中每个元素又都是一个 Hash，包含两个元素，
    # value 指定 cookie 的文本，expires 指定 cookie 的失效日期。
    # 例如，我们可以使用上述代码实现登录功能，把 cookie 的值设为用户的记忆权标，失效日期设为 20 年之后；
    # Rails 特别提供了 permanent 方法，把 cookie 的失效日期设为 20 年后
    # cookies[:remember_token] = { value: user.remember_token, expires: 20.years.from_now.utc }

    # 可能听说过，存储在用户浏览器中的验证 cookie 在和服务器通讯时可能会导致程序被会话劫持，攻击者只需复制记忆权标就可以伪造成相应的用户登录网站了。
    # Firesheep 这个 Firefox 扩展可以查看会话劫持，你会发现很多著名的大网站（包括 Facebook 和 Twitter）都存在这种漏洞。
    # 避免这个漏洞的方法就是整站开启 SSL
    
    self.current_user = user # 加上 self 之后，赋值操作就会把值赋值给SessionsHelper的 current_user 属性
    # 行代码创建了 current_user 方法，可以在控制器和视图中使用：  <%= current_user.name %>
		# 也可以这样用： redirect_to current_user


    # 这是一个赋值操作，必须先定义相应的方法才能这么用。Ruby 为这种赋值操作提供了一种特别的定义方式：如下一个方法
  end

  # 这段代码定义的 current_user= 方法是用来处理 current_user 赋值操作的
  # 也就是说: self.current_user = ... 会自动转换成下面这种形式: current_user=(...)
  def current_user=(user) 
    @current_user = user
  end

  # 通常还会定义 current_user 方法，用来读取 @current_user 的值
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # 定义 current_user? 方法
  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil # 这行是为了兼容不转向的退出操作
    cookies.delete(:remember_token)
  end

  # 在某个地方存储这个页面的地址，登录后再转向这个页面。
  # 通过两个方法来实现这个过程，store_location 和 redirect_back_or
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
