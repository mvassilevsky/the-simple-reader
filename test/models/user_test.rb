# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  new_posts_first        :boolean          default(TRUE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unread_only            :boolean          default(TRUE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_unread_posts
    read_post = posts(:post_1)
    assert_not(users(:user_1).unread_posts.include?(read_post))

    unread_post = posts(:post_2)
    assert(users(:user_1).unread_posts.include?(unread_post))
  end

  def test_bookmarked?
    unbookmarked_post = posts(:post_1)
    assert_not(users(:user_1).bookmarked?(unbookmarked_post))

    bookmarked_post = posts(:post_3)
    assert(users(:user_1).bookmarked?(bookmarked_post))
  end
end
