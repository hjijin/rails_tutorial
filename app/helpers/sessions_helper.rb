module SessionsHelper
	# 2012-12-12/11:11
	def sign_in(user)
	    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
	    self.current_user = user
	  end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user?(user)
		user == current_user
	end
	# 2012-12-15/18:40
	def authenticate
	  deny_access unless signed_in?
	end

	def deny_access
		store_location 
	  redirect_to signin_path, :notice => "Please sign in to access this page."
	end

	# 登陆后返回刚访问的页面
	def store_location
		session[:return_to] = request.fullpath
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		cleat_return_to
	end

	def cleat_return_to
		session[:return_to] = nil #防止退出后再登陆还是退出前访问的页面
	end

	private

		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token]||[nil, nil]
		end
end

