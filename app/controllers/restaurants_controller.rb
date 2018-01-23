class RestaurantsController < ApplicationController
  # move (使用者登入的認證程序 before_action :authenticate_user!) to applicationController
  before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite, :like, :unlike]

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  
  def show
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite]

    # 評論的form_for需傳入@comment
    @comment = Comment.new
  end

  def dashboard
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite]
  end

  # 展示最新的10筆餐廳和10筆評論
  def feeds
    @recent_restaurant = Restaurant.order(created_at: :desc).limit(10)
    @recent_comment = Comment.order(created_at: :desc).limit(10)
  end

  # Favorite Controller Action
  def favorite
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite]
    if @restaurant.favorites.exists?(:user_id => current_user.id)
      # 若 table favorites已存在關聯就不再增加
      flash.now[:info] = "You have alreday favorite this restaurant!"
    else 
      @restaurant.favorites.create!(user: current_user)
      redirect_back(fallback_location: root_path)
    end
  end

  def unfavorite
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite]
    @favorites = Favorite.where(restaurant: @restaurant, user: current_user) 
    @favorites.destroy_all # @favorites 可能多於一筆因此用destroy_all
    redirect_back(fallback_location: root_path)
  end

    # Favorite Controller Action
  def like
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite]
    if @restaurant.likes.exists?(:user_id => current_user.id)
      # 若 table favorites已存在關聯就不再增加
      flash.now[:info] = "You have alreday liked this restaurant!"
    else 
      @restaurant.likes.create!(user: current_user)
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
    # before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite]
    @likes = Like.where(restaurant: @restaurant, user: current_user) 
    @likes.destroy_all # @favorites 可能多於一筆因此用destroy_all
    redirect_back(fallback_location: root_path)
  end

  #
  # private
  #
  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
