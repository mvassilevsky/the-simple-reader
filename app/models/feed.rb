# == Schema Information
#
# Table name: feeds
#
#  id          :bigint           not null, primary key
#  favicon_url :string
#  title       :string           not null
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_feeds_on_url  (url) UNIQUE
#

class Feed < ApplicationRecord
  validates :title, :url, presence: true
  validates :url, uniqueness: true

  has_many :posts

  # Creates a new feed from a feed url.
  #
  # @param url [String] the feed's url
  # @return [Feed] the created feed
  def self.create_from_url(url)
    feed = new(url: url)
    feed.parse_and_save
  end

  def parse_and_save
    begin
      parsed_feed = Feedjira.parse(HTTParty.get(url).body)
      self.favicon_url = build_favicon_url(url)
      self.title = parsed_feed.title
      save if changed?
      parse_and_save_posts(parsed_feed)
    rescue Feedjira::NoParserAvailable, Errno::ECONNREFUSED
      errors.add(:url, 'invalid')
    end
    self
  end

  private

  def parse_and_save_posts(parsed_feed)
    empty_feed = posts.none?
    parsed_feed.entries.each do |entry|
      post = Post.parse(entry)
      posts << post if empty_feed || post.new_post?
    end
  end

  def build_favicon_url(url)
    parsed_url = URI.parse(url)
    icon_url = "#{parsed_url.scheme}://#{parsed_url.host}/favicon.ico"
    return icon_url if
      HTTParty.head(icon_url).headers.content_type.starts_with?('image')
    return nil
  end
end
