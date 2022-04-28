class ChangeUserIdToRequesterIdOnFrienship < ActiveRecord::Migration[7.0]
  change_table :friendships do |t|
    t.rename :user_id, :requester_id
  end
end
