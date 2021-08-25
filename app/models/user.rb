# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  new_posts_first        :boolean          default(TRUE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unread_only            :boolean          default(TRUE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_feeds
  has_many :feeds, through: :user_feeds
  has_many :posts, through: :feeds
  has_many :user_posts
  has_many :bookmarked_posts, -> { where(user_posts: { bookmarked: true }) },
           through: :user_posts, source: :post
  has_many :unread_posts, -> (user) {
             where.not(
              'EXISTS(' \
                'SELECT post_id ' \
                'FROM user_posts ' \
                'WHERE read = TRUE AND post_id = posts.id AND user_id = ? ' \
              ')', user.id
             )
           }, through: :feeds, source: :posts, class_name: 'Post'
  has_many :notes

  # Returns whether a post has been bookmarked by this user.
  #
  # @param post [Post]
  # @return [TrueClass|FalseClass] whether the user has bookmarked this post
  def bookmarked?(post)
    user_posts.where(post_id: post.id, bookmarked: true).exists?
  end

  def post_order
    return :desc if new_posts_first
    :asc
  end
end
