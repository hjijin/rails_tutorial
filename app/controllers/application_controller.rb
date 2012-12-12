class ApplicationController < ActionController::Base
  protect_from_forgery
  # 2012-12-12/11:45
  include SessionsHelper
end
