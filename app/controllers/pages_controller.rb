class PagesController < ApplicationController
	#2012-12-6/09:00
  def home
  	@title = "Home"
    # 2012-12-16/11:26
    # @micropost = Micropost.new if signed_in?
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end
  #2012-12-6/09:00
  def contact
  	@title = "Contact"
  end
  #2012-12-6/09:00
  def about
  	@title = "About"
  end
  #2012-12-7/16:22
  def help
    @title = "Help"
  end
end
