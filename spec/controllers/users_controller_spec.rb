require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'POST /users' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it "creates a new user" do
      post :create, params: {user: {
        email: 'prb@mail.com',
        password: '123456'
      }}
      expect(response.status).to eq(201)
    end
    it "should not create new user without email" do
      post :create, params: {user: {
        email: nil,
        password: '123456'
      }}
      expect(response.status).to eq(422)
    end
    it "should not create new user without password" do
      post :create, params: {user: {
        email: 'prb@mail.com',
        password: nil
      }}
      expect(response.status).to eq(422)
    end
  end
end