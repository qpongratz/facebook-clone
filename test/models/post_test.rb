require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @new_post = posts(:newer)
  end

  test '#newest_first' do
    assert_equal Post.all.newest_first.first, @new_post
  end

end
