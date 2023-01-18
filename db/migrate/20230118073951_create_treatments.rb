class CreateTreatments < ActiveRecord::Migration[7.0]
  def change
    create_table :treatments do |t|
      t.integer :quantity
      t.timestamps
    end
    add_reference :treatments, :admission, foreign_key: true
    add_reference :treatments, :medicine, foreign_key: true
  end
end
