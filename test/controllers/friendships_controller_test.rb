require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:mary)
    sign_in @user
    @friend_user = users(:friendless)
  end

  test "should get create" do
    assert_difference('Friendship.count') do
      post "/users/#{@friend_user.id}/friendships"
    end
  end

  # test "should get destroy" do
  #   get friendships_destroy_url
  #   assert_response :success
  # end
end
