# == Schema Information
#
# Table name: feeds
#
#  id          :bigint           not null, primary key
#  favicon_url :string
#  title       :string           not null
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Feed < ApplicationRecord
  has_many :posts
end
