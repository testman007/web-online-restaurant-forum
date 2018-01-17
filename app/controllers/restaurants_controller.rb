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

  # 展示最新的10筆餐廳和10筆評論
  def feeds
    @recent_restaurant = Restaurant.order(created_at: :desc).limit(10)
    @recent_comment = Comment.order(created_at: :desc).limit(10)
  end
end
