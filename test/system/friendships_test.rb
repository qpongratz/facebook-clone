require "application_system_test_case"

class FriendshipsTest < ApplicationSystemTestCase
  setup do
    @user = users(:mary)
    sign_in @user
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  # test "should create friendship when adding friend" do
  #   visit posts_url
  #   click_on "New post"

  #   fill_in "Content", with: @post.content
  #   click_on "Create Post"

  #   assert_text "Post was successfully created"
  #   assert_selector 'h1', text: 'Posts'
  # end

  # test "should accept friend when accepting friendship" do
  #   visit post_url(@post)
  #   click_on "Edit this post", match: :first

  #   fill_in "Content", with: @post.content
  #   click_on "Update Post"

  #   assert_text "Post was successfully updated"
  #   assert_selector 'h1', text: 'Posts'
  # end

  # test "should destroy friendship when rejecting" do
  #   visit post_url(@post)
  #   click_on "Destroy this post", match: :first

  #   assert_text "Post was successfully destroyed"
  # end

  # test "should destroy friendship" do
  #   visit post_url(@post)
  #   click_on "Destroy this post", match: :first

  #   assert_text "Post was successfully destroyed"
  # end
end
