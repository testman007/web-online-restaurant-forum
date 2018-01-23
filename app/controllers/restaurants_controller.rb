class RestaurantsController < ApplicationController
  # move (使用者登入的認證程序 before_action :authenticate_user!) to applicationController
  before_action :set_restaurant, only: [:show, :dashboard]

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  
  def show
    # before_action :set_restaurant, only: [:show, :dashboard]

    # 評論的form_for需傳入@comment
    @comment = Comment.new
  end

  def dashboard
    # before_action :set_restaurant, only: [:show, :dashboard]
  end

  # 展示最新的10筆餐廳和10筆評論
  def feeds
    @recent_restaurant = Restaurant.order(created_at: :desc).limit(10)
    @recent_comment = Comment.order(created_at: :desc).limit(10)
  end

  #
  # private
  #
  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
