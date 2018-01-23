class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  #設定Model關聯 => belongs_to 後面要接單數
  belongs_to :category, optional: true
  #設定Model關聯 => has_many 後面要接複數
  has_many :comments, dependent: :destroy
  #設定 favorite和restaurant的model關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
end
