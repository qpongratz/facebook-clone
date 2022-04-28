class Friendship < ApplicationRecord
  enum :status, %i[pending accepted]
  belongs_to :requester, class_name: 'User'
  belongs_to :friend, class_name: 'User'
end
