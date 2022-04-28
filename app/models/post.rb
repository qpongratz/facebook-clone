class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  scope :newest_first, -> { order(created_at: :desc) }
end
