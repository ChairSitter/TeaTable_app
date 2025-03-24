class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  # The user_id and friend_id columns are foreign keys that reference the users table.
end
