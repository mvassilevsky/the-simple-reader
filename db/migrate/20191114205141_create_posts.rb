class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :feed_id, null: false
      t.string :title
      t.string :author
      t.string :content
      t.string :url

      t.index :feed_id

      t.timestamps
    end
  end
end
