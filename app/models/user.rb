class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :outgoing_friendships, class_name: 'Friendship', foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :friends, through: :outgoing_friendships
  has_many :requesters, through: :incoming_friendships
  has_many :accepted_friends

  def active_friends
    friends.merge(outgoing_friendships.accepted) + requesters.merge(incoming_friendships.accepted)
  end

  def pending_friends
    pending_incoming + pending_outgoing
  end

  def pending_incoming
    requesters.merge(incoming_friendships.pending)
  end

  def pending_outgoing
    friends.merge(outgoing_friendships.pending)
  end

  def friend_status(user)
    return 'active' if active_friends.include?(user)
    return 'outgoing' if pending_outgoing.include?(user)
    return 'incoming' if pending_incoming.include?(user)

    'none'
  end
end
