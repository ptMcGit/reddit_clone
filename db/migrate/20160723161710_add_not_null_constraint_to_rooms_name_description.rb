class AddNotNullConstraintToRoomsNameDescription < ActiveRecord::Migration
  def change
    change_column_null :rooms, :name, false
    change_column_null :rooms, :description, false
  end
end
