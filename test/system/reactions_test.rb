require "application_system_test_case"

class ReactionsTest < ApplicationSystemTestCase
  setup do
    @unliked_post = posts(:newer)
    @liked_post = posts(:one)
    @user = users(:mary)
    sign_in @user
  end

  test 'should create reaction' do
    visit posts_url
    within "div#post_#{@unliked_post.id}" do
      click_on 'Like this post', match: :first
      assert_text '1 like'
    end

    assert_selector 'h1', text: 'Posts'
  end

  test 'should destroy reaction' do
    visit posts_path
    within "div#post_#{@liked_post.id}" do
      click_on 'Unlike this post', match: :first
      assert_text '0 likes'
    end

    assert_selector 'h1', text: 'Posts'
  end
end
