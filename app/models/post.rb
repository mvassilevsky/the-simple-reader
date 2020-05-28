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
  NON_CONTENT_TAGS_REGEX =
    /<((script)|(style)|(link))>.*?<((\/script)|(\/style)|(\/link))>/

  validates :feed_id, presence: true

  belongs_to :feed
  has_many :user_posts

  # Initializes a Post from a Feedjira parsed entry.
  def self.parse(feed_entry)
    content = feed_entry.content
    content = feed_entry.summary if content.nil?
    Post.new(author: feed_entry.author,
             content: sanitize_content(content),
             title: feed_entry.title,
             url: feed_entry.url,
             posted_at: feed_entry.published)
  end

  # Checks whether this post has already been saved, based on the feed and
  # posted time.
  #
  # @return [TrueClass|FalseClass] whether the post is new
  def new_post?
    new_record? && Post.where(feed_id: feed_id, posted_at: posted_at).none?
  end

  def read_by?(user)
    # Not a database query because that causes N+1 queries.
    user_posts.any? do |user_post|
      user_post.user_id == user.id && user_post.read
    end
  end

  private

  def self.sanitize_content(html)
    contentful_html = html.gsub(NON_CONTENT_TAGS_REGEX, '')
    ActionController::Base.helpers.sanitize(contentful_html)
  end
end
