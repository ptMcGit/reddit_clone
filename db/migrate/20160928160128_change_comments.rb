class ChangeComments < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.rename      :post_id, :commentable_id
      t.column      :commentable_type, :string
      t.index      [:commentable_type, :commentable_id]
    end
    execute <<-SQL
      UPDATE comments
        SET commentable_type = 'Post'
    SQL
  end
  def down
    change_table :comments do |t|
      t.rename          :commentable_id, :post_id
      t.remove          :commentable_type
    end
  end
end
