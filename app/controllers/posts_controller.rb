class PostsController < ApplicationController
  def bookmark
    user_post = UserPost.find_or_create_by!(user_id: current_user.id,
                                            post_id: params[:id])
    user_post.bookmark!
    redirect_back(fallback_location: root_path)
  end

  def unbookmark
    user_post = UserPost.find_or_create_by!(user_id: current_user.id,
                                            post_id: params[:id])
    user_post.unbookmark!
    redirect_back(fallback_location: root_path)
  end
end
