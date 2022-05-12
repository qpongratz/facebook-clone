require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = comments(:one)
    @user = users(:mary)
    sign_in @user
  end

  test "should get index" do
    get post_comments_url(@post)
    assert_response :success
  end

  test "should get new" do
    get new_post_comment_url(@post)
    assert_response :success
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { content: @comment.content, user_id: @comment.user_id, commentable_type: @comment.commentable_type, commentable_id: @comment.commentable_id } }
    end

    assert_redirected_to @post
  end

  test "should show comment" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { content: @comment.content, user_id: @comment.user_id, commentable_type: @comment.commentable_type, commentable_id: @comment.commentable_id } }
    assert_redirected_to @post
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to root_path
  end
end
