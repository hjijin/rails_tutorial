module ApplicationHelper
	# 返回每页的基本标题
	#2012-12-7/11:00
	def title
		base_title = "Ruby on Rails Tutorial Sample App"
		if @title.present?
			"#{base_title} | #{@title}"
		else
			base_title
		end
	end	

	#2012-12-7/16:46
	def logo
		image_tag("logo.png", :alt => "Sample App", :class => "round")
	end
end
