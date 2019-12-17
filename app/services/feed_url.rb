class FeedUrl
  SITES = [Sites::Blogspot].freeze

  # @param url [String] feed or site url
  def self.feed_url(url)
    normal_url = normalized_url(url)
    at_root = URI.parse(normal_url).path.blank?
    if at_root
      site = SITES.find { |site| site.match?(normal_url) }
      return site.feed_url(normal_url) unless site.nil?
      normal_url
    else
      normal_url
    end
  end

  # Returns a normalized URL that will identify the feed. Removes trailing
  # slashes.
  #
  # @param url [String] url to be normalized
  # @return [String] normalized url
  def self.normalized_url(url)
    parsed_url = URI.parse(url.downcase)
    parsed_url.path = parsed_url.path.gsub(/\/+$/, '')
    parsed_url.to_s
  end
end
