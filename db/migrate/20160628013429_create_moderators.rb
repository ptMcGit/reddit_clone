class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.integer :user_id,    null: false
      t.integer :room_id,    null: false
      t.timestamps null: false
    end
  end
end
