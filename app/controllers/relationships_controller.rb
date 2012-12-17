# 2012-12-17/10:00
class RelationshipsController < ApplicationController
	before_filter :authenticate
	respond_to :html, :js

	def create
		# raise params.inspect
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		# redirect_to @user
		# 2012-12-17/10:35
		# respond_to do |format|
		# 	format.html { redirect_to @user }
		# 	format.js
		# end
		respond_with @user
	end

	def destroy
		# relationship = Relationship.find(params[:id]).destroy
		# redirect_to relationship.followed

		# 第二种实现方式：
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		# redirect_to @user
		# respond_to do |format|
		# 	format.html { redirect_to @user }
		# 	format.js
		# end
		respond_with @user
	end
end
