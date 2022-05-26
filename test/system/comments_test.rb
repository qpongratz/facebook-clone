# require "application_system_test_case"

# class CommentsTest < ApplicationSystemTestCase
#   setup do
#     @post = posts(:one)
#     @user = users(:mary)
#     @comment = comments(:one)
#     sign_in @user
#   end

#   test 'should create comment' do
#     visit posts_url
#     within "div#post_#{@post.id}" do
#       click_on 'Add a comment', match: :first
#     end

#     fill_in 'Content', with: 'Hello'
#     click_on 'Create Comment'

#     assert_text 'Hello'
#     assert_selector 'h1', text: 'Posts'
#   end

#   test 'should update comment' do
#     visit posts_url
#     within "li#comment_#{@comment.id}" do
#       click_on 'Edit this comment', match: :first
#     end

#     fill_in 'Content', with: 'Goodbye'
#     click_on 'Update Comment'

#     assert_text 'Goodbye'
#     assert_selector 'h1', text: 'Posts'
#   end

#   test 'should destroy comment' do
#     visit posts_path
#     within "li#comment_#{@comment.id}" do
#       click_on 'Destroy this comment', match: :first
#     end

#     assert_no_selector "li#comment_#{@comment.id}"
#   end
# end
