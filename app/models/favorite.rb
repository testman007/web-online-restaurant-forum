class Favorite < ApplicationRecord
  # 設定Model關聯 => belongs_to 後面要接單數
  belongs_to :user
  belongs_to :restaurant 
end
