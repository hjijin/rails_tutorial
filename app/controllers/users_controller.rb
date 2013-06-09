class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy # 限制只有管理员才能访问 destroy 动作的事前过滤器

  def index
    # @users = User.all # @users 的值是通过 User.all 方法获取的，是个数组；而 will_paginate 方法需要的是 ActiveRecored::Relation 类对象。
    @users = User.paginate(page: params[:page]) 
    #paginate 方法所需的 :page 参数值由 params[:page] 指定，这个 params 元素是由 will_pagenate 自动生成的。
  end

  def new
    if signed_in?
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id]) # params[:id] 返回的是字符串 "1"，find 方法会自动将其转换成整数形式
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user # 用户注册后直接登录
    	flash[:success] = "Welcome to Rails's World!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end
  # 既然 correct_user 事前过滤器中已经定义了 @user，这两个动作中就不再需要再定义 @user 变量了。
  def edit
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(params[:user])
  #     flash[:success] = "Profile updated"
  #     sign_in @user
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end
  # 既然 correct_user 事前过滤器中已经定义了 @user，这两个动作中就不再需要再定义 @user 变量了。
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy # 把 find 方法和 destroy 方法链在一起使用了
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private 
    # 在 Microposts 控制器中也要用到，那么就把它移到 Sessions 的帮助方法中
    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_path, notice: "Please sign in." #unless signed_in? 
    #     #flash[:error] 也可以使用上述的简便方式，但 flash[:success] 却不可以
    #   end
    # end

    # 保护 edit 和 update 动作的 correct_user 事前过滤器
    # 下面correct_user 方法使用了 current_user? 方法，要在 Sessions 帮助方法模块中定义一下
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
