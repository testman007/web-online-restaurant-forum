class RestaurantsController < ApplicationController
  # move (使用者登入的認證程序 before_action :authenticate_user!) to applicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  
  def show
    @restaurant = Restaurant.find(params[:id])
    # 評論的form_for需傳入@comment
    @comment = Comment.new
  end
end
