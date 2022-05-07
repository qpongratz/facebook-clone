class AddCounterCachesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_count, :integer
    add_column :posts, :reactions_count, :integer
  end
end
