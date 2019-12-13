class Sites::Site
  # Returns whether a URL points to a subclass's site.
  #
  # @param url [String] site url
  # @return [TrueClass\FalseClass]
  def self.match?(url)
    raise NotImplementedError
  end

  # Returns the feed url for a given site.
  #
  # @param url [String] site url
  # @return [String] feed url for the site
  def self.feed_url(url)
    raise NotImplementedError
  end
end
