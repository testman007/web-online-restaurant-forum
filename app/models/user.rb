class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # 設定Model關聯 => has_many 後面要加複數
  has_many :comments
  # 設定與 restaurants關聯
  has_many :restaurants, through: :comments
  #
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

  #################################################
  # For followship 功能
  #################################################
  # 設定 user和followship的 Model關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 判斷是否已經追蹤user
  def following?(user)
    self.followings.include?(user)
  end

  # 讓 User 可以找到他的追蹤者
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  

  #################################################
  # For friendship 功能
  #################################################
  # 設定 好友(friendships)和使用者(User)的 Model關聯
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # 讓 User 可以找到加他朋友的人員名單
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  # 1. 顯示 User送出好友邀請的名單
  has_many :invite_friends, -> { where "status = 0" },
  class_name: "Friendship", foreign_key: "user_id", dependent: :destroy
  has_many :invite_friends_list, through: :invite_friends, source: :user
  # 2. 顯示 User未確認成為好友的名單
  has_many :invited_friends, -> { where "status = 0" }, foreign_key: "friend_id" , dependent: :destroy
  has_many :invited_friends_list, through: :invited_friends, source: :user
  # 3. 顯示 User已經成為好友的名單
  has_many :become_friendships, -> { where "status = 1" }, class_name: "Friendship", dependent: :destroy
  has_many :become_friends_list, through: :become_friendships, source: :user

  # 判斷是否已經是friend
  def friends?(user)
    self.friends.include?(user)
  end

  # all_friends => 無論是使用者主動加入、或由別人提出的好友關係，都會包括在 all_friends 的回傳結果裡
  def all_friends    
    friends = self.friends + self.inverse_friends
    return friends.uniq
  end

  #################################################
end
