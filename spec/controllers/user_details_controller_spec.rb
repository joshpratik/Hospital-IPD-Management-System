require 'rails_helper'

RSpec.describe UserDetailsController, type: :controller do
  context 'GET /user_details' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it 'should return all users details' do
      get :index
      expect(response.status).to eq(200)
    end
  end
  context 'POST /user_details' do
    let!(:role) { create :role, name: 'staff'}
    let!(:role1) { create :role, name: 'patient'}
    let!(:role2) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it 'should create user details with valid attributes' do
      post :create, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: '1996-11-06',
        gender: 'male',
        phone_no: '8806056123'
      }}
      expect(response.status).to eq(201)
    end
    it 'should not create user details without first name' do
      post :create, params: {user_detail: {
        first_name: nil,
        last_name: 'baravkar',
        date_of_birth: '1996-11-06',
        gender: 'male',
        phone_no: '8806056123'
      }}
      expect(response.status).to eq(422)
    end
    it 'should not create user details without date of birth' do
      post :create, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: nil,
        gender: 'male',
        phone_no: '8806056123'
      }}
      expect(response.status).to eq(422)
    end
    it 'should not create user details without gender' do
      post :create, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: '1996-11-06',
        gender: nil,
        phone_no: '8806056123'
      }}
      expect(response.status).to eq(422)
    end
    it 'should not create user details without phone number' do
      post :create, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: '1996-11-06',
        gender: 'male',
        phone_no: nil
      }}
      expect(response.status).to eq(422)
    end
  end
  context 'PUT /user_details' do
    let!(:role) { create :role, name: 'staff'}
    let!(:role1) { create :role}
    let!(:valid_user) { create :user, :valid }
    let!(:user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:user_detail1) { create :user_detail, :valid, role: role1, user: user}
    before do
      sign_in(valid_user)
    end
    it 'should update the user in database' do
      put :update, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: '1996-11-06',
        gender: 'male',
        phone_no: '8806056123'
      }, id: user_detail1.id}
      expect(response.status).to eq(200)
    end
    it 'should not update the user in database without valid atrributes' do
      put :update, params: {user_detail: {
        first_name: 'pratik',
        last_name: 'baravkar',
        date_of_birth: nil,
        gender: 'male',
        phone_no: '8806056123'
      }, id: user_detail1.id}
      expect(response.status).to eq(422)
    end
  end
  context 'GET /user_details' do
    let!(:role) { create :role, name: 'staff'}
    let!(:role1) { create :role}
    let!(:valid_user) { create :user, :valid }
    let!(:user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:user_detail1) { create :user_detail, :valid, role: role1, user: user}
    before do
      sign_in(valid_user)
    end
    it 'should return the user in database' do
      get :show, params: { id: user_detail1.id}
      expect(response.status).to eq(200)
    end
  end
end