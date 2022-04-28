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

  # inside of my outgoing friendships find all where status is accepted
  # Give me the friend_id of those
  # inside of my incoming friendships find all where status is accepted
  # Give me the requester_id of those

  def active_friends
    outgoing_friendships.accepted + incoming_friendships.accepted
  end

  # def active_friends
  #   friends.select { |friend| friend.friends.include?(self) }
  # end

  # def pending_incoming
  #   requesters.reject { |requester| friends.include?(requester) }
  # end

  # def pending_outgoing
  #   friends.reject { |friend| friend.friends.include?(self) }
  # end
end
