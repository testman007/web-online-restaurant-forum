class Admin::CategoriesController < Admin::BaseController
  # before_action :authenticate_user! => 在application_controller.rb 統一管理
  before_action :authenticate_admin
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all

    if params[:id]
      set_category
    else
      @category = Category.new
    end
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

  def update
    # before_action :set_category
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:warning] = "category was successfully update"
    else
      @category = Category.all
      render :index
    end
  end

  def destroy
    # before_action :set_category
    @category.destroy
    flash[:warning] = "category was successfully deleted"
    redirect_to admin_categories_path
  end
  
  #private area
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
