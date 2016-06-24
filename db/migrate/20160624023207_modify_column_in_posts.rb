class ModifyColumnInPosts < ActiveRecord::Migration
  def change
    change_column_null :posts, :user_id, false
    change_column_null :posts, :room_id, false
  end
end
