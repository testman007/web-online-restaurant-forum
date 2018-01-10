class Admin::BaseController < ApplicationController
  # 使用者登入的認證程序 
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end