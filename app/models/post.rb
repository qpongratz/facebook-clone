class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { ordered }, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :content, presence: true

  scope :newest_first, -> { order(created_at: :desc) }

  def self.friends_posts(user)
    where(user: user.friends).or(where(user: user))
  end
end
