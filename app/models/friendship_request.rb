class FriendshipRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :requester_id, presence: true, uniqueness: { scope: :receiver_id }, comparison: { other_than: :receiver_id }
  validates :receiver_id, presence: true, uniqueness: { scope: :requester_id }
  validate :no_existing_friendship
  validate :inverse_does_not_exist

  def self.find_either(user_a, user_b)
    find_by(requester: user_a, receiver: user_b) ||
      find_by(requester: user_b, receiver: user_a)
  end

  private

  def no_existing_friendship
    return unless Friendship.exists?(user_id: requester_id, friend_id: receiver_id)

    errors.add(:requester, 'is already friends with receiver')
  end

  def inverse_does_not_exist
    return unless FriendshipRequest.exists?(requester_id: receiver_id, receiver_id: requester_id)

    errors.add(:requester_id, 'is already in an existing inverse request')
  end
end
