class UsersController < ApplicationController
  # before_action :authenticate_user! => 在application_controller.rb 統一管理
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # before_action :set_user, only: [:show, :edit, :update]
    @commented_restaurants = @user.restaurants
  end

  def edit
    # before_action :set_user, only: [:show, :edit, :update]
  end

  def update
    # before_action :set_user, only: [:show, :edit, :update]
    if @user.id == current_user.id
      if @user.update(user_params)
        flash[:info] = "User was successfully updated"
        redirect_to user_path(@user)
      else
        flash.now[:info] = "User was failed to updated"
        render :edit
      end
    else
      flash.now[:info] = "You have no right to change this page"
      render :edit
    end
  end

  #
  # private
  #
  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    #before_action
    @user = User.find(params[:id])    
  end
end
