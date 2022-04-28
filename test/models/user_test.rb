require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:mary)
  end
  test '#active_friends' do
    assert_equal 2, @user.active_friends.count
  end
end
