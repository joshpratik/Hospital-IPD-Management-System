class CreateUserDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :user_details do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender
      t.string :phone_no
      t.timestamps
    end
    add_reference :user_details, :role, foreign_key: true
  end
end
