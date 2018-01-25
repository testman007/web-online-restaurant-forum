class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # 設定Model關聯 => has_many 後面要加複數
  has_many :comments
  # 設定與 restaurants關聯
  has_many :restaurants, through: :comments

  def admin?
    self.role == "admin"
  end

  # 
  validates_presence_of :name
  # 將user.rb Model掛載至 CarrierWave 的 Uploader
  mount_uploader :avatar, AvatarUploader

  #設定 favorite和restaurant的model關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  #設定 like和restaurant的model關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 設定 user和followship的 Model關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  #
  # 判斷是否已經追蹤user
  #
  def following?(user)
    self.followings.include?(user)
  end

  #
  # 讓 User 可以找到他的追蹤者
  #
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #設定 好友(friendships)和使用者(User)的 Model關聯
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  #
  # 判斷是否已經是friend
  #
  def friends?(user)
    self.friends.include?(user)
  end
end
