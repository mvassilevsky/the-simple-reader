class Sites::Blogspot < Sites::Site
  def self.match?(url)
    parsed_url = URI.parse(url)
    parsed_url.path.blank? && parsed_url.host.include?('blogspot')
  end

  def self.feed_url(url)
    parsed_url = URI.parse(url)
    parsed_url.path = '/feeds/posts/default'
    parsed_url.to_s
  end
end
