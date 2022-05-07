class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  validates :user_id, uniqueness: {
    scope: %i[reactable_type reactable_id],
    message: 'Only one like per person per thing'}
end
