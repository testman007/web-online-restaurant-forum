class CommentsController < ApplicationController
  def create
    # 確認餐廳物件
    @restaurant = Restaurant.find(params[:restaurant_id])
    # 透過關聯建立一個新的評論 => build == new 一樣的用法
    @comment = @restaurant.comments.build(comment_params)
    # 確認關聯的使用者
    @comment.user = current_user
    # 存入資料庫並重新導向
    @comment.save!
    redirect_to restaurant_path(@restaurant)
  end

  #
  # private 
  #
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
