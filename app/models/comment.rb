class Comment < ApplicationRecord
  has_many :child_comments, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent_comment, class_name: 'Comment', optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
