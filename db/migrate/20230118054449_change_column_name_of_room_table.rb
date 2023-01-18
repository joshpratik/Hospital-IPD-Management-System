class ChangeColumnNameOfRoomTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :rooms, :type, :room_type
  end
end
