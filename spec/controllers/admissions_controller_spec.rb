require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do
  context 'POST /create' do
    let!(:role_staff) { create :role, name: 'staff'}
    let!(:role_patient) { create :role, name: 'patient'}
    let!(:staff) { create :user, :valid }
    let!(:staff_detail) { create :user_detail, :valid, role: role_staff, user: staff }
    let!(:patient_detail) { create :user_detail, :valid, role: role_patient, user: nil }
    let!(:room) { create :room }
    let!(:room2) { create :room }
    let!(:available_resource) { create :available_resource, room: room}
    let!(:available_resource2) { create :available_resource, available_capacity: 0, room: room2}
    before do
      sign_in(staff)
    end
    it 'should create admission with valid admission parameters' do
      post :create, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil,
                             staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room.id)}
      expect(response.status).to eq(201)
    end
    it 'should not create admission if room capacity is 0' do
      post :create, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil,
                             staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room2.id)}
      expect(response.status).to eq(422)
    end
    it 'should not create admission with invalid parameters' do
      post :create, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil,
                             staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room2.id)}
      expect(response.status).to eq(422)
    end
  end
end