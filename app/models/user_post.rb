# == Schema Information
#
# Table name: user_posts
#
#  id         :bigint           not null, primary key
#  bookmarked :boolean          default(FALSE)
#  read       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_user_posts_on_bookmarked           (bookmarked)
#  index_user_posts_on_post_id              (post_id)
#  index_user_posts_on_read                 (read)
#  index_user_posts_on_user_id              (user_id)
#  index_user_posts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Bookmarks a post for a user.
  def bookmark!
    return self if bookmarked?
    update!(bookmarked: true)
  end

  # Unbookmarks a post for a user.
  def unbookmark!
    return self unless bookmarked?
    update!(bookmarked: false)
  end
end
