class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user

  has_many :reactions, as: :reactable, dependent: :destroy

  validates :content, presence: true
  validates :commentable_id, :commentable_type, presence: true

  scope :ordered, -> { order(id: :asc) }
end
