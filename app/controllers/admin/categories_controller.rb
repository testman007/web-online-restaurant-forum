class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:warning] = "category was successfully saved"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index 
    end
  end
  
  #private area
  private

  def category_params
    params.require(:category).permit(:name)
  end

end
