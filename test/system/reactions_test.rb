require "application_system_test_case"
require 'pry'

class ReactionsTest < ApplicationSystemTestCase
  setup do
    @unliked_post = posts(:newer)
    @liked_post = posts(:one)
    @user = users(:mary)
    sign_in @user
    Post.reset_counters(@liked_post.id, :reactions)
  end

  test 'should create reaction' do
    visit posts_url
    within "div#post_#{@unliked_post.id}" do
      within 'div.post_stats_reactions' do
        assert_no_text '1'
      end
      click_on 'Like', match: :first
      within 'div.post_stats_reactions' do
        assert_text '1'
      end
    end
  end

  test 'should destroy reaction' do
    visit posts_path
    within "div#post_#{@liked_post.id}" do
      within 'div.post_stats_reactions' do
        assert_text '1'
      end

      click_on 'Like', match: :first

      within 'div.post_stats_reactions' do
        assert_no_text '1'
      end
    end
  end
end
