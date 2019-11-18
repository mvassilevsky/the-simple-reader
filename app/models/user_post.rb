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
#  index_user_posts_on_user_id_and_post_id_and_read_and_saved  (user_id,post_id,read,saved)
#

class UserPost < ApplicationRecord
end
