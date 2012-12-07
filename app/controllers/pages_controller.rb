class PagesController < ApplicationController
	#2012-12-6/09:00
  def home
  	@title = "Home"
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
