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
  validates :feed_id, presence: true

  belongs_to :feed

  # Initializes a Post from a Feedjira parsed entry.
  def self.parse(feed_entry)
    Post.new(author: feed_entry.author,
             content: sanitize_content(feed_entry.content),
             title: feed_entry.title,
             posted_at: feed_entry.published)
  end

  # Checks whether this post has already been saved, based on the feed and
  # posted time.
  #
  # @return [TrueClass|FalseClass] whether the post is new
  def new_post?
    new_record? && Post.where(feed_id: feed_id, posted_at: posted_at).none?
  end

  private

  def self.sanitize_content(html)
    ActionController::Base.helpers.sanitize(html)
  end
end
