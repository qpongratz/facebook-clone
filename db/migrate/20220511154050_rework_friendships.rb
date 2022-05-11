class ReworkFriendships < ActiveRecord::Migration[7.0]
  def change
    rename_column :friendships, :requester_id, :user_id
    remove_column :friendships, :status, :integer
  end
end
