# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text
#  private    :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Note < ApplicationRecord
  belongs_to :user

  DEFAULT_TITLE = 'unititled note'.freeze
  PLACEHOLDER_TEXT = 'Write your note here!'.freeze

  before_create do
    self.title = DEFAULT_TITLE if self.title.blank?
  end
end
