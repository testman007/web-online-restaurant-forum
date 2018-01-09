class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  #設定Modle關聯 => belongs_to 後面要接單數
  belongs_to :category, optional: true
end
