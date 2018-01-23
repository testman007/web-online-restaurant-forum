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
end
