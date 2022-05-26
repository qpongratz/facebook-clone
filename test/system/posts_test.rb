require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:mary)
    sign_in @user
  end

  test 'visiting the index' do
    visit posts_url
    assert_content @post.content
  end

  test 'should create post when signed in' do
    visit posts_url
    within '#new_post' do
      fill_in 'Content', with: 'Hello'
      find('button[aria-label=submit]').click
    end

    assert_text 'Hello'
  end

  test 'should update Post' do
    visit posts_url
    within "div#post_#{@post.id}" do
      find('button[aria-label=options]').click
      click_on 'Edit', match: :first

      within "#post_#{@post.id}_content" do
        fill_in 'Content', with: 'Goodbye'
        find('button[aria-label=submit]').click
      end

      assert_text 'Goodbye'
    end
  end

  test 'should destroy Post' do
    visit posts_path
    within "div#post_#{@post.id}" do
      find('button[aria-label=options]').click
      click_on 'Delete', match: :first
    end

    assert_no_selector "div#post_#{@post.id}"
  end
end
