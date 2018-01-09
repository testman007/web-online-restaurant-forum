class Category < ApplicationRecord
  #設定Modle關聯 => has_many 後面要接複數
  has_many :restaurants, dependent: :destroy
end
