class ChangeMessageIdToPostIdInVotes < ActiveRecord::Migration
  def change
    rename_column :votes, :message_id, :post_id
  end
end
