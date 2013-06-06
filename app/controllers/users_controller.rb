class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # params[:id] 返回的是字符串 "1"，find 方法会自动将其转换成整数形式
  end

  def create
    @user = User.new(params[:user])
    if @user.save
    	flash[:success] = "Welcome to Rails's World!"
      redirect_to @user
    else
      render 'new'
    end
  end

end
