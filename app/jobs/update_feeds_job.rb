class UpdateFeedsJob < ApplicationJob
  queue_as :default

  def perform
    Feed.pluck(:id).each { |feed_id| UpdateFeedJob.perform_later(feed_id) }
  end
end
