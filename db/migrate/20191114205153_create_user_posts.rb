class CreateUserPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_posts do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :read, default: false
      t.boolean :bookmarked, default: false

      t.index :user_id
      t.index :post_id
      t.index [:user_id, :post_id], unique: true
      t.index :read
      t.index :bookmarked

      t.timestamps
    end
  end
end
