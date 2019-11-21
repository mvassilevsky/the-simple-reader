class CreateUserFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :user_feeds do |t|
      t.integer :user_id
      t.integer :feed_id

      t.index :user_id
      t.index :feed_id
      t.index [:user_id, :feed_id], unique: true

      t.timestamps
    end
  end
end
