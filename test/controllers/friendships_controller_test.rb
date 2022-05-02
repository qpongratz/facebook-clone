require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:mary)
    sign_in @user
    @friend_user = users(:friendless)
  end

  test "should get create" do
    assert_difference('Friendship.count') do
      post user_friendships_url(@friend_user)
    end
  end
end
