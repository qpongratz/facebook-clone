class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :friendships, foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :requesters, through: :incoming_friendships
end
