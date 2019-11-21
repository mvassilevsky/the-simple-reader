class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds
    if params[:bookmarked]
      @posts = current_user.bookmarked_posts
    else
      @posts = current_user.posts.order(posted_at: :desc)
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feeds = current_user.feeds
    if params[:bookmarked]
      @posts = current_user.bookmarked_posts.where(feed_id: @feed.id)
    else
      @posts = @feed.posts.order(posted_at: :desc)
    end
  end
end
