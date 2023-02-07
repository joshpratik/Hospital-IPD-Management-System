require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  context 'POST /addresses' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it 'should create address with valid paramaters' do
      post :create, params: { address: {
        locality: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        pin: Faker::Number.number(digits: 6),
        user_detail_id: user_detail.id
      }}
      expect(response.status).to eq(201)
    end
    it 'should not create address with invalid paramaters' do
      post :create, params: { address: {
        locality: Faker::Address.street_address,
        city: nil,
        state: nil,
        pin: nil,
        user_detail_id: user_detail.id
      }}
      expect(response.status).to eq(422)
    end
  end
  context 'PUT /addresses' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:address) { create :address, :valid, user_detail: user_detail}
    before do
      sign_in(valid_user)
    end
    it 'should update address with valid paramaters' do
      put :update, params: { address: {
        locality: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        pin: Faker::Number.number(digits: 6),
        user_detail_id: user_detail.id
      }, id: address.id}
      expect(response.status).to eq(200)
    end
    it 'should not update address with invalid paramaters' do
      put :update, params: { address: {
        locality: Faker::Address.street_address,
        city: nil,
        state: nil,
        pin: nil,
        user_detail_id: user_detail.id
      }, id: address.id}
      expect(response.status).to eq(422)
    end
  end
  context 'GET /addresses/:id' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:address) { create :address, :valid, user_detail: user_detail}
    before do
      sign_in(valid_user)
    end
    it 'should return address of given id' do
      get :show, params: {id: address.id}
      expect(response.status).to eq(200)
    end
  end
  
end