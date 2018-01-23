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
  #設定 like和restaurant的model關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # favorite關聯是否存在？
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  # like關聯是否存在？
  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
