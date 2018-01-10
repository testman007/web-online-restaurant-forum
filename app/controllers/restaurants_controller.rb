class RestaurantsController < ApplicationController
  # move (使用者登入的認證程序 before_action :authenticate_user!) to applicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
    @categories = Category.all
  end
  
end
