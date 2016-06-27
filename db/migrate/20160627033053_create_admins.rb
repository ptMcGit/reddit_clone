class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
