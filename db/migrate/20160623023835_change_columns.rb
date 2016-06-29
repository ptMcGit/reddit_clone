class ChangeColumns < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, :integer
    change_column :posts, :room_id, :integer
    change_column :votes, :message_id, :integer
  end
end
