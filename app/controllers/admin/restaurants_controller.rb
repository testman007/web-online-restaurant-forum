class Admin::RestaurantsController < Admin::BaseController
  # before_action :authenticate_user! => 在application_controller.rb 統一管理
  # before_action :authenticate_admin => 在base_controller.rb 統一管理
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  
  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:info] = "Restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:info] = "Restaurant was failed to create"
      render :new
    end
  end

  def show
    #before_action :set_restaurant
  end

  def edit
    #before_action :set_restaurant
  end

  def destroy
    # before_action :set_restaurant
    @restaurant.destroy

    redirect_to admin_restaurants_path
    flash[:info] = "Restaurant was deleted!" 
  end

  def update
    #before_action :set_restaurant
    if @restaurant.update(restaurant_params)
      flash[:info] = "Restaurant was successfully updated"
      redirect_to admin_restaurants_path(@restaurant)
    else
      flash.now[:info] = "Restaurant was failed to updated"
      render :edit
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
  end

  def set_restaurant
    #before_action
    @restaurant = Restaurant.find(params[:id])    
  end

end
