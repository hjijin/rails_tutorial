module ApplicationHelper
	
	# 如果视图中没有定义标题，full_title 会返回标题的公共部分，即“Rails Tutorial”；如果定义了，则会在公共部分后面加上一个竖杠，然后再接上该页面的标题
	def full_title(page_title)
    base_title = "Rails Tutorial"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
