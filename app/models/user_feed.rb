# == Schema Information
#
# Table name: user_feeds
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feed_id    :string
#  user_id    :string
#
# Indexes
#
#  index_user_feeds_on_feed_id  (feed_id)
#  index_user_feeds_on_user_id  (user_id)
#

class UserFeed < ApplicationRecord
end
