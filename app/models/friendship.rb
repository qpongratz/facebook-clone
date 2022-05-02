class Friendship < ApplicationRecord
  enum :status, %i[pending accepted]
  belongs_to :requester, class_name: 'User'
  belongs_to :friend, class_name: 'User'
  validates :requester_id, presence: true, uniqueness: { scope: :friend_id }, comparison: { other_than: :friend_id }
  validates :friend_id, presence: true, uniqueness: { scope: :requester_id }

  def member?(user)
    requester == user || friend == user
  end
end
