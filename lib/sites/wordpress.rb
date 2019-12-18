class Sites::Wordpress < Sites::Site
  def self.match?(url)
    parsed_url = URI.parse(url)
    parsed_url.path.blank? && parsed_url.host.include?('wordpress')
  end

  def self.feed_url(url)
    parsed_url = URI.parse(url)
    parsed_url.path = '/feed'
    parsed_url.to_s
  end
end
