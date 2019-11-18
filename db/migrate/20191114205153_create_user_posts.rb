class CreateUserPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_posts do |t|
      t.string :user_id
      t.string :post_id
      t.boolean :read, default: false
      t.boolean :saved, default: false

      t.index :user_id
      t.index :post_id
      t.index :read
      t.index :saved

      t.timestamps
    end
  end
end