require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do
  context 'POST /admissions' do
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
      post :create, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil, admission_date: nil,
                             dignostic: nil, staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room.id)}
      expect(response.status).to eq(422)
    end
  end

  context 'PUT /admissions/:id' do
    let!(:role_staff) { create :role, name: 'staff'}
    let!(:role_patient) { create :role, name: 'patient'}
    let!(:staff) { create :user, :valid }
    let!(:staff_detail) { create :user_detail, :valid, role: role_staff, user: staff }
    let!(:patient_detail) { create :user_detail, :valid, role: role_patient, user: nil }
    let!(:room) { create :room }
    let!(:available_resource) { create :available_resource, room: room }
    let!(:admission) { create :admission, staff: staff_detail, patient: patient_detail, room: room }
    before do
      sign_in(staff)
    end
    it 'should update admission with valid admission parameters' do
      put :update, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil,
                             staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room.id),
                             id: admission.id }
      expect(response.status).to eq(200)
    end
    it 'should not update admission with invalid parameters' do
      put :update, params: { admission: FactoryBot.attributes_for(:admission, discharge_date: nil, admission_date: nil,
                             dignostic: nil, staff_id: staff_detail.id, patient_id: patient_detail.id, room_id: room.id),
                             id: admission.id }
      expect(response.status).to eq(422)
    end
  end

  context 'GET /admissions/:id' do
    let!(:role_staff) { create :role, name: 'staff'}
    let!(:role_patient) { create :role, name: 'patient'}
    let!(:staff) { create :user, :valid }
    let!(:staff_detail) { create :user_detail, :valid, role: role_staff, user: staff }
    let!(:patient_detail) { create :user_detail, :valid, role: role_patient, user: nil }
    let!(:room) { create :room }
    let!(:available_resource) { create :available_resource, room: room }
    let!(:admission) { create :admission, staff: staff_detail, patient: patient_detail, room: room }
    before do
      sign_in(staff)
    end
    it 'should return admission with given admission id' do
      get :show, params: { id: admission.id }
      expect(response.status).to eq(200)
    end
  end

  context 'GET /admissions/:id' do
    let!(:role_staff) { create :role, name: 'staff'}
    let!(:role_patient) { create :role, name: 'patient'}
    let!(:staff) { create :user, :valid }
    let!(:staff_detail) { create :user_detail, :valid, role: role_staff, user: staff }
    let!(:patient_detail) { create :user_detail, :valid, role: role_patient, user: nil }
    let!(:room) { create :room }
    let!(:available_resource) { create :available_resource, room: room }
    let!(:admission) { create :admission, staff: staff_detail, patient: patient_detail, room: room }
    before do
      sign_in(staff)
    end
    it 'should update admission_status as discharged with current date as discharge date' do
      delete :destroy, params: { id: admission.id }
      expect(response.status).to eq(200)
    end
  end
end