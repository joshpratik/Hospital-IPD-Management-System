require 'rails_helper'

RSpec.describe TreatmentsController, type: :controller do
  context 'POST /create' do
    let!(:role_staff) { create :role, name: 'staff'}
    let!(:role_patient) { create :role, name: 'patient'}
    let!(:staff) { create :user, :valid }
    let!(:staff_detail) { create :user_detail, :valid, role: role_staff, user: staff }
    let!(:patient_detail) { create :user_detail, :valid, role: role_patient, user: nil }
    let!(:medicine) { create :medicine }
    let!(:room) { create :room }
    let!(:admission) { create :admission, staff: staff_detail, patient: patient_detail, room: room }
    let!(:admission2) { create :admission, staff: staff_detail, patient: patient_detail, room: room }
    let!(:treatment) { create :treatment, medicine: medicine, admission: admission2 }
    before do
      sign_in(staff)
    end
    it 'should create valid treatment with valid parameters' do
      post :create, params: { treatment: {
        admission_id: admission.id,
        medicine_id: medicine.id,
        quantity: Faker::Number.between(from: 1, to: 1000)
      }}
      expect(response.status).to eq(201)
    end
    it 'should not create valid treatment without invalid parameters' do
      post :create, params: { treatment: {
        admission_id: admission.id,
        medicine_id: medicine.id,
        quantity: nil
      }}
      expect(response.status).to eq(422)
    end
    it 'should update treatment if treatment is alerady present' do
      post :create, params: { treatment: {
        admission_id: admission2.id,
        medicine_id: medicine.id,
        quantity: Faker::Number.between(from: 1, to: 1000)
      }}
      expect(response.status).to eq(200)
    end
  end
end