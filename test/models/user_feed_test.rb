# == Schema Information
#
# Table name: user_feeds
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feed_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_user_feeds_on_feed_id  (feed_id)
#  index_user_feeds_on_user_id  (user_id)
#

require 'test_helper'

class UserFeedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
