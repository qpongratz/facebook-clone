require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:mary)
    @friendship = friendships(:mary_joe)
    sign_in @user
  end

  test "should destroy friendship and inverse" do
    assert_difference("Friendship.count", -2) do
      delete friendship_url(@friendship)
    end
  end
end
