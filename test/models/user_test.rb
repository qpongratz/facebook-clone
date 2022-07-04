require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @mary = users(:mary)
    @friendless = users(:friendless)
    @friendship = friendships(:mary_joe)
    @joe = users(:joe)
  end

  test '#all_except' do
    not_mary = User.all_except(@mary)
    assert_includes not_mary, @friendless
    assert_includes not_mary, @joe
    refute_includes not_mary, @mary
  end

  test 'name' do
    assert_equal @mary.name, "#{@mary.first_name} #{@mary.last_name}"
  end
end
