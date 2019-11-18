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

class Post < ApplicationRecord
  belongs_to :feed
end
