class CreateUserFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :user_feeds do |t|
      t.string :user_id
      t.string :feed_id

      t.index [:user_id, :feed_id]

      t.timestamps
    end
  end
end
