require 'rails_helper'

RSpec.describe Admission, type: :model do
  let (:patient) { create :role, name: 'patient' }
  let (:staff) { create :role, name: 'staff' }
  let (:user) { create :user, :valid }
  let (:staff_detail) { create :user_detail, :valid, role: staff, user: user }
  let (:patient_detail) { create :user_detail, :valid, role: patient, user: nil }
  let (:room) { create :room}
  let (:admission) { build :admission, patient: patient_detail, staff: staff_detail, room: room}
  it 'should create valid admission with valid parameters' do
    expect(admission.valid?).to eq(true)
  end
  it 'should not create admission without admission date' do
    admission.admission_date = nil
    expect(admission.valid?).to eq(false)
  end
  it 'should not create admission without dignostic' do
    admission.dignostic = nil
    expect(admission.valid?).to eq(false)
  end
  it 'should not create admission without admission status' do
    admission.admission_status = nil
    expect(admission.valid?).to eq(false)
  end
end
