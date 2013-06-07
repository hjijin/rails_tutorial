class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  # 默认情况下帮助函数只可以在视图中使用，不能在控制器中使用，而我们需要同时在控制器和视图中使用帮助函数，所以我们就手动引入帮助函数所在的模块。
end
