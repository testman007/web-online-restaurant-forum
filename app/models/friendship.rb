class Friendship < ApplicationRecord
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user, class_name: "User", foreign_key: "user_id", primary_key: "id"
  belongs_to :friends, class_name: "User", foreign_key: "friend_id", primary_key: "id"
end
