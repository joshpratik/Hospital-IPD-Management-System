require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  context 'POST /users/sign_in ' do
    let!(:user) { create :user, :valid }
    let!(:role) { create :role, name: 'admin'}
    let!(:user_detail) { create :user_detail, :valid, role: role, user: user}
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    it 'should sign in with valid credintials' do
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      expect(response.status).to eq(200)
    end

    it 'should not sign in with invalid credintials' do
      post :create, params: {
        user: {
          email: user.email,
          password: '123'
        }
      }
      expect(response.status).to eq(401)
    end
  end

  # context 'DELETE /users/sign_out' do
  #   let(:user) { create :user, :valid }
  #   # let(:headers) {{ 'Authorization' => "Bearer #{user.generate_jwt}" }}
  #   before do
  #     @request.env['devise.mapping'] = Devise.mappings[:user]
  #   end

  #   it 'should sign out the user' do
  #     delete :destroy
  #     expect(response.status).to eq(200)
  #   end
  # end
end