require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:mary)
  end

  test '#active_friends' do
    assert_equal 2, @user.active_friends.count
  end

  test '#pending_incoming' do
    assert_equal 0, @user.pending_incoming.count
  end

  test '#pending_outgoing' do
    assert_equal 1, @user.pending_outgoing.count
  end

  test '#pending_friends' do
    assert_equal 1, @user.pending_friends.count
  end
end
