class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }, comparison: { other_than: :friend_id }
  validates :friend_id, presence: true, uniqueness: { scope: :user_id }

  after_save :create_inverse
  after_destroy :destroy_inverse

  private

  def destroy_inverse
    Friendship.destroy_by(user: friend, friend: user)
  end

  def create_inverse
    Friendship.find_or_create_by(user: friend, friend: user)
  end
end
