require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @new_post = posts(:newer)
    @mary = users(:mary)
    @joe_post = posts(:joe_post)
    @friendless_post = posts(:friendless_post)
  end

  test '#newest_first' do
    assert_equal Post.all.newest_first.first, @new_post
  end

  test '#friends_posts' do
    friends_posts = Post.friends_posts(@mary)
    assert_includes friends_posts, @joe_post
    refute_includes friends_posts, @friendless_post
  end

end
