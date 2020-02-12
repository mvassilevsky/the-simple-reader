class FeedsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_up_feed, :only => [:index, :show]

  def index
  end

  def show
    @feed = Feed.find(params[:id])
    @posts = @posts.where(feed_id: @feed.id)
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
    flash[:error] = feed.errors.full_messages if feed.errors.any?
    redirect_back(fallback_location: root_path)
  end

  def unsubscribe
    feed_id = params[:id]
    UserFeed.destroy_by(user_id: current_user.id, feed_id: feed_id)
    redirect_to feeds_path
  end

  private

  def set_up_feed
    @feeds = current_user.feeds
    @bookmarked_only = params[:bookmarked] == 'true'
    @bookmarked_posts = current_user.bookmarked_posts.load
    @posts = if params[:bookmarked]
               @bookmarked_posts
             elsif current_user.unread_only
               current_user.unread_posts
             else
               current_user.posts
             end
    @posts = @posts.includes(:feed, :user_posts).order(posted_at: post_order)
  end

  def post_order
    current_user.post_order
  end
end
