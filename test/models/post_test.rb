# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  author     :string
#  content    :string
#  posted_at  :datetime         not null
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feed_id    :integer          not null
#
# Indexes
#
#  index_posts_on_feed_id    (feed_id)
#  index_posts_on_posted_at  (posted_at)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:post_1)
  end

  def test_new_post?
    duplicate_post = @post.dup
    assert_not(duplicate_post.new_post?)

    duplicate_post = Post.new(feed_id: @post.feed_id,
                               posted_at: @post.posted_at)
    assert_not(duplicate_post.new_post?)

    new_post = Post.new
    assert(new_post.new_post?)
  end

  def test_read_by?
    assert(@post.read_by?(users(:user_1)))

    assert_not(@post.read_by?(users(:user_2)))
  end
end
