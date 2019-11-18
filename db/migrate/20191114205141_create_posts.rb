class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :feed_id, null: false
      t.string :title
      t.string :author
      t.string :content
      t.string :url
      t.datetime :posted_at, null: false

      t.index :feed_id
      t.index :posted_at

      t.timestamps
    end
  end
end
