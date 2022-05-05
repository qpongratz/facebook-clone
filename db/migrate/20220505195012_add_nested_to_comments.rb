class AddNestedToComments < ActiveRecord::Migration[7.0]
  def self.up
    # add_column :categories, :parent_id, :integer # Comment this line if your project already has this column
    Comment.where(parent_id: 0).update_all(parent_id: nil) # Uncomment this line if your project already has :parent_id
    add_column :comments, :lft,       :integer
    add_column :comments, :rgt,       :integer

    # optional fields
    add_column :comments, :depth,          :integer
    add_column :comments, :children_count, :integer

    # This is necessary to update :lft and :rgt columns
    Comment.reset_column_information
    Comment.rebuild!
  end

  def self.down
    remove_column :comments, :lft
    remove_column :comments, :rgt

    # optional fields
    remove_column :comments, :depth
    remove_column :comments, :children_count
  end
end
