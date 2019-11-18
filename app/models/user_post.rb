# == Schema Information
#
# Table name: user_posts
#
#  id         :bigint           not null, primary key
#  read       :boolean          default(FALSE)
#  saved      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :string
#  user_id    :string
#
# Indexes
#
#  index_user_posts_on_post_id  (post_id)
#  index_user_posts_on_read     (read)
#  index_user_posts_on_saved    (saved)
#  index_user_posts_on_user_id  (user_id)
#

class UserPost < ApplicationRecord
end
