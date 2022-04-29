require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @mary = users(:mary)
    @friendship = friendships(:mary_joe_accepted)
    @joe = users(:joe)
    @bill = users(:bill)
  end

  test '#active_friends' do
    assert_equal 2, @mary.active_friends.count
  end

  test '#pending_incoming' do
    assert_equal 0, @mary.pending_incoming.count
  end

  test '#pending_outgoing' do
    assert_equal 1, @mary.pending_outgoing.count
  end

  test '#pending_friends' do
    assert_equal 1, @mary.pending_friends.count
  end

  test '#find_friendship' do
    assert_equal @friendship, @mary.find_friendship(@joe)
    assert_equal @friendship, @joe.find_friendship(@mary)
    assert_not_equal @friendship, @mary.find_friendship(@bill)
  end
end
