class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :locality
      t.string :city
      t.string :state
      t.integer :pin
      t.timestamps
    end
    add_reference :addresses, :user_detail, foreign_key: true
  end
end
