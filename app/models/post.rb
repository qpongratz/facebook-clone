class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { ordered }, as: :commentable, dependent: :destroy

  validates :content, presence: true

  scope :newest_first, -> { order(created_at: :desc) }

  def self.friends_posts(user)
    friends = user.active_friends
    where(user: friends).or(where(user: user))
  end
end
