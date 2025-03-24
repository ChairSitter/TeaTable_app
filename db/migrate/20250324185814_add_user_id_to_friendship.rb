class AddUserIdToFriendship < ActiveRecord::Migration[8.0]
  def change
    add_column :friendships, :user_id, :integer
    add_column :friendships, :friend_id, :integer
  end
end
