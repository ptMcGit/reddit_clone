class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text "content"
      t.string "user_id"
      t.string "room_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_column :messages, :post_id, :integer
  end
end
