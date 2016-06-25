class RenameMessagesTableToCommentsTable < ActiveRecord::Migration
  def change
    rename_table :messages, :comments
  end
end
