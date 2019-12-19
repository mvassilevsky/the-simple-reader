class UpdateFeedJob < ApplicationJob
  queue_as :default

  def perform(feed_id)
    Feed.find(feed_id).parse_and_save
  end
end
