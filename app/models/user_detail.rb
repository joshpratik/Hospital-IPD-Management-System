class UserDetail < ApplicationRecord
  belongs_to :role
  has_one :user
  has_one :address
  has_many :patient, class_name: 'Admission', foreign_key: 'patient_id'
  has_many :staff, class_name: 'Admission', foreign_key: 'staff_id'
end
