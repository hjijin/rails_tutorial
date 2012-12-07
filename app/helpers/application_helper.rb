module ApplicationHelper
	# 返回每页的基本标题
	 
	def title
		base_title = "Ruby on Rails Tutorial Sample App"
		if @title.present?
			"#{base_title} | #{@title}"
		else
			base_title
		end
	end	
end
