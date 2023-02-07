require 'rails_helper'

RSpec.describe Treatment, type: :model do
  let (:patient) { create :role, name: 'patient' }
  let (:staff) { create :role, name: 'staff' }
  let (:user) { create :user, :valid }
  let (:staff_detail) { create :user_detail, :valid, role: staff, user: user }
  let (:patient_detail) { create :user_detail, :valid, role: patient, user: nil }
  let (:room) { create :room}
  let (:admission) { create :admission, patient: patient_detail, staff: staff_detail, room: room}
  let (:medicine) { create :medicine}
  let (:treatment) { build :treatment, admission: admission, medicine: medicine}
  it 'should create valid treatment with valid parameters' do
    expect(treatment.valid?).to eq(true)
  end
  it 'should not create treatment without quantity' do
    treatment.quantity = nil
    expect(treatment.valid?).to eq(false)
  end
end
