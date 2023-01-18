class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :type
      t.string :description
      t.integer :charges
      t.integer :capacity
      t.timestamps
    end
  end
end
