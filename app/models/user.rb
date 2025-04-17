class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :friend_requests, foreign_key: :sender_id, dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: :receiver_id, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def all_friendships
    Friendship.where(user_id: self.id).or(Friendship.where(friend_id: self.id))
  end
end
