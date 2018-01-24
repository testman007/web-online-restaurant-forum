class Friendship < ApplicationRecord
  validates :friendship_id, uniqueness: { scope: :user_id }

  belongs_to :user, class_name: "User", foreign_key: "user_id", primary_key: "id"
  belongs_to :friendship, class_name: "User", foreign_key: "friendship_id", primary_key: "id"
end
