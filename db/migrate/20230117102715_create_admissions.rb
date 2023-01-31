class CreateAdmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :admissions do |t|
      t.date :admission_date
      t.date :discharge_date
      t.string :dignostic
      t.string :admission_status
      t.bigint :patient_id
      t.bigint :staff_id
      t.timestamps
    end
    add_reference :admissions, :room, foreign_key: true
    add_foreign_key :admissions, :user_details, column: :patient_id
    add_foreign_key :admissions, :user_details, column: :staff_id
  end
end
