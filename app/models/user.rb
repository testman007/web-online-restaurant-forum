class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # 設定Model關聯 => has_many 後面要加複數
  has_many :comments

  def admin?
    self.role == "admin"
  end

  # 將user.rb Model掛載至 CarrierWave 的 Uploader
  mount_uploader :avatar, AvatarUploader
end
