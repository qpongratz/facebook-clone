class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  # has_many :outgoing_requests, class_name: 'FriendshipRequest', foreign_key: :requester, dependent: :destroy
  # has_many :incoming_requests, class_name: 'FriendshipRequest', foreign_key: :receiver, dependent: :destroy
  # has_many :requesters, through: :incoming_requests
  # has_many :receivers, through: :outgoing_requests
  # has_many :friendships, dependent: :destroy
  # has_many :inverse_friendships, foreign_key: :friend, dependent: :destroy
  # has_many :friends, through: :friendships

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  has_many :outgoing_friendships, class_name: 'Friendship', foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :friends, through: :outgoing_friendships
  has_many :requesters, through: :incoming_friendships
  has_many :accepted_friends

  scope :all_except, ->(user) { where.not(id: user) }

  def name
    "#{first_name} #{last_name}"
  end

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

  def find_friendship(user)
    if friends.include?(user)
      outgoing_friendships.find_by(friend_id: user.id)
    elsif requesters.include?(user)
      incoming_friendships.find_by(requester_id: user.id)
    end
  end

  def friend_status(user)
    return 'active' if active_friends.include?(user)
    return 'outgoing' if pending_outgoing.include?(user)
    return 'incoming' if pending_incoming.include?(user)

    'none'
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
