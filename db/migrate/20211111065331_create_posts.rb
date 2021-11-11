class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :likes_view
      t.integer :dislikes_view

      t.timestamps
    end
  end
end
