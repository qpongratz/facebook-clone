class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :outgoing_requests, class_name: 'FriendshipRequest', foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_requests, class_name: 'FriendshipRequest', foreign_key: :receiver_id, dependent: :destroy
  has_many :requesters, through: :incoming_requests
  has_many :receivers, through: :outgoing_requests
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, foreign_key: :friend, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user) }

  def requests
    incoming_requests + outgoing_requests
  end

  def name
    "#{first_name} #{last_name}"
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
