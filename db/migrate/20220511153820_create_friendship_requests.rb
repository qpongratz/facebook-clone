class CreateFriendshipRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friendship_requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
