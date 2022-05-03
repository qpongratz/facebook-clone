class Friendship < ApplicationRecord
  enum :status, %i[pending accepted]
  belongs_to :requester, class_name: 'User'
  belongs_to :friend, class_name: 'User'
  validates :requester_id, presence: true, uniqueness: { scope: :friend_id }, comparison: { other_than: :friend_id }
  validates :friend_id, presence: true, uniqueness: { scope: :requester_id }

  # scope :between, -> (user_a_id, user_b_id) {
  #   find_by(requester_id: user_a_id, friend_id: user_b_id)
  # }

  def self.between(user_a, user_b)
    find_by(requester: user_a, friend: user_b) ||
      find_by(requester: user_b, friend: user_a)
  end

  def member?(user)
    requester == user || friend == user
  end
end
