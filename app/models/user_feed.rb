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
#  index_user_feeds_on_user_id_and_feed_id  (user_id,feed_id)
#

class UserFeed < ApplicationRecord
end
