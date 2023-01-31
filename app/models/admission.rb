class Admission < ApplicationRecord
  belongs_to :patient, class_name: 'UserDetail'
  belongs_to :staff, class_name: 'UserDetail'
  has_many :treatments
  has_many :medicines, through: :treatments
  belongs_to :room
  validates :admission_date, :dignostic, :admission_status, presence: true
end
