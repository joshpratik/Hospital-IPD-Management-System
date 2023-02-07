require 'rails_helper'

RSpec.describe MedicinesController, type: :controller do
  context 'POST /medicines' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    before do
      sign_in(valid_user)
    end
    it 'should create medicine with valid parameters' do
      post :create, params: {medicine: FactoryBot.attributes_for(:medicine)}
      expect(response.status).to eq(201)
    end
    it 'should not create medicine with invalid parameters' do
      post :create, params: {medicine: FactoryBot.attributes_for(:medicine, name: nil)}
      expect(response.status).to eq(422)
    end
  end
  context 'PUT /medicines' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:medicine) { create :medicine }
    before do
      sign_in(valid_user)
    end
    it 'should update medicine with valid parameters' do
      put :update, params: {medicine: FactoryBot.attributes_for(:medicine),
                            id: medicine.id}
      expect(response.status).to eq(200)
    end
    it 'should not update medicine with invalid parameters' do
      put :update, params: {medicine: FactoryBot.attributes_for(:medicine, name: nil),
                            id: medicine.id}
      expect(response.status).to eq(422)
    end
  end
  context 'GET /medicines/:id' do
    let!(:role) { create :role, name: 'admin'}
    let!(:valid_user) { create :user, :valid }
    let!(:user_detail) { create :user_detail, :valid, role: role, user: valid_user}
    let!(:medicine) { create :medicine }
    before do
      sign_in(valid_user)
    end
    it 'should return medicine with given id' do
      get :show, params: { id: medicine.id}
      expect(response.status).to eq(200)
    end
  end
end