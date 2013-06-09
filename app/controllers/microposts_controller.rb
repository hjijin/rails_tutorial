class MicropostsController < ApplicationController
	before_filter :signed_in_user
	# 注意，现在没有明确指定事前过滤器要限制的动作有哪几个，因为默认情况下仅有的两个动作都会被限制。
	# 如果要加入第三个动作，例如 index 动作，未登录的用户可以访问，就要明确的指定要限制的动作了
	# before_filter :signed_in_user, only: [:create, :destroy]
  
	before_filter :correct_user,   only: :destroy

	def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end
end