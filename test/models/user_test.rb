require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @mary = users(:mary)
    @friendless = users(:friendless)
    @friendship = friendships(:mary_joe)
    @joe = users(:joe)
  end


end
