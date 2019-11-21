# == Schema Information
#
# Table name: user_posts
#
#  id         :bigint           not null, primary key
#  bookmarked :boolean          default(FALSE)
#  read       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_user_posts_on_bookmarked           (bookmarked)
#  index_user_posts_on_post_id              (post_id)
#  index_user_posts_on_read                 (read)
#  index_user_posts_on_user_id              (user_id)
#  index_user_posts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

require 'test_helper'

class UserPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
