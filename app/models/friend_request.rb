class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  # The sender_id and receiver_id columns are foreign keys that reference the users table.
end
