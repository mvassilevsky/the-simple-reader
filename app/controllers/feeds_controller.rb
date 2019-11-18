class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds
    @posts = @current_user.posts.order(posted_at: :desc)
  end
end
