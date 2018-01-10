class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 使用者登入的認證程序 
  before_action :authenticate_user!
end
