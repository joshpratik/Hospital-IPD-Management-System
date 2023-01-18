class CreateAvailableResources < ActiveRecord::Migration[7.0]
  def change
    create_table :available_resources do |t|
      t.integer :available_capacity
      t.timestamps
    end
    add_reference :available_resources, :room, foreign_key: true
  end
end
