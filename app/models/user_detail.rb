class UserDetail < ApplicationRecord
  belongs_to :role
  belongs_to :user, optional: true
  has_one :address
  has_many :patient, class_name: 'Admission', foreign_key: 'patient_id'
  has_many :staff, class_name: 'Admission', foreign_key: 'staff_id'
  validates :first_name, :date_of_birth, :gender, :phone_no, presence: true
  validates :phone_no, length: { is: 10 }
end
