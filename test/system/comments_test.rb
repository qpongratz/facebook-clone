require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:mary)
    @comment = comments(:one)
    sign_in @user
    Post.reset_counters(@post.id, :comments)
  end

  test 'should create comment' do
    visit posts_url
    within "div#post_#{@post.id}" do
      fill_in 'Content', with: 'Hello'
      find('button[aria-label=submit]').click
    end
    assert_text 'Hello'
  end

  test 'should update comment' do
    visit posts_url
    within "div#post_#{@post.id}" do
      click_on '1 comment', match: :first
      within "div#comment_#{@comment.id}" do
        find('button[aria-label=options]', visible: false).click
        click_on 'Edit', match: :first
        fill_in 'Content', with: 'Goodbye'
        find('button[aria-label=submit]').click
      end

      assert_text 'Goodbye'
    end
  end

  test 'should delete comment' do
    visit posts_url
    within "div#post_#{@post.id}" do
      click_on '1 comment', match: :first
      within "div#comment_#{@comment.id}" do
        find('button[aria-label=options]', visible: false).click
        click_on 'Delete', match: :first
      end

      assert_no_selector "div#comment_#{@comment.id}"
    end
  end
end
