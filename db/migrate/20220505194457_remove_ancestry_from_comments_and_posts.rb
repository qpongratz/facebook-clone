class RemoveAncestryFromCommentsAndPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :ancestry, :string
    remove_column :posts, :ancestry, :string
  end
end
