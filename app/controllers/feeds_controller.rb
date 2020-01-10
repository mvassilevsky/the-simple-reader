class FeedsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def index
    @feeds = current_user.feeds
    if params[:bookmarked]
      @posts = current_user.bookmarked_posts.order(posted_at: post_order)
    else
      @posts = current_user.posts.order(posted_at: post_order)
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feeds = current_user.feeds
    if params[:bookmarked]
      @posts =
        current_user.bookmarked_posts.where(feed_id: @feed.id).order(post_order)
    else
      @posts = @feed.posts.order(posted_at: post_order)
    end
  end

  def create
    url = FeedUrl.feed_url(params[:feed][:url])
    feed = Feed.find_by_url(url)
    if feed && !current_user.feeds.exists?(feed.id)
      current_user.feeds << feed
    elsif feed.nil?
      feed = Feed.create_from_url(url)
      current_user.feeds << feed if feed.persisted?
    end
    redirect_back(fallback_location: root_path,
                  flash: { error: feed.errors.full_messages })
  end

  def unsubscribe
    feed_id = params[:id]
    UserFeed.destroy_by(user_id: current_user.id, feed_id: feed_id)
    redirect_to feeds_path
  end

  private

  def post_order
    current_user.post_order
  end
end
