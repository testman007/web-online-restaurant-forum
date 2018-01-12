class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  #設定Model關聯 => belongs_to 後面要接單數
  belongs_to :category, optional: true
  #設定Model關聯 => has_many 後面要接複數
  has_many :comments
end
