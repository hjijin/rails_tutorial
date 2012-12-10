module UsersHelper
	# 2012-12-10/10:54
	def gravatar_for(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => user.name, 
																						:class => 'gravatar', 
																						:gravatar => options)
	end
end
