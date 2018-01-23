class Category < ApplicationRecord
  # 確定新增餐廳分類時有輸入"分類名稱""
  validates_presence_of :name
  # 設定Modle關聯 => has_many 後面要接複數
  has_many :restaurants, dependent: :destroy
  # has_many :restaurants, dependent: :restrict_with_exception
  # has_many :restaurants, dependent: :restrict_with_error
  # 確定餐廳分類的名稱不重複
  validates_uniqueness_of :name
end
