require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:mary)
    sign_in @user
  end

  test 'visiting the index' do
    visit posts_url
    assert_selector 'h1', text: 'Posts'
  end

  test 'should create post when signed in' do
    visit posts_url
    click_on 'New post'

    fill_in 'Content', with: 'Hello'
    click_on 'Create Post'

    assert_text 'Hello'
    assert_selector 'h1', text: 'Posts'
  end

  test 'should update Post' do
    visit posts_url
    click_on 'Edit this post', match: :first

    fill_in 'Content', with: 'Goodbye'
    click_on 'Update Post'

    assert_text 'Goodbye'
    assert_selector 'h1', text: 'Posts'
  end

  test 'should destroy Post' do
    visit posts_path
    within "div#post_#{@post.id}" do
      click_on 'Destroy this post', match: :first
    end

    assert_no_selector "div#post_#{@post.id}"
  end
end
