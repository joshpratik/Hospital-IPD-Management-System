require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  context 'POST /rooms' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it 'should create room with valid parameters' do
      post :create, params: {room: FactoryBot.attributes_for(:room)}
      expect(response.status).to eq(201)
    end
    it 'should not create room with invalid parameters' do
      post :create, params: {room: FactoryBot.attributes_for(:room, room_type: nil)}
      expect(response.status).to eq(422)
    end
  end
  context 'PUT /rooms/:id' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:room) { create :room }
    before do
      sign_in(valid_user)
    end
    it 'should update room with valid parameters' do
      put :update, params: {room: FactoryBot.attributes_for(:room, room_type: 'general'),
                            id: room.id}
      expect(response.status).to eq(200)
    end
    it 'should not update room with invalid parameters' do
      put :update, params: {room: FactoryBot.attributes_for(:room, room_type: nil),
                            id: room.id}
      expect(response.status).to eq(422)
    end
  end
  context 'GET /rooms/:id' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:room) { create :room }
    before do
      sign_in(valid_user)
    end
    it 'should return room with given id' do
      get :show, params: { id: room.id }
      expect(response.status).to eq(200)
    end
  end
end