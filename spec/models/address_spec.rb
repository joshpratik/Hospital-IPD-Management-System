require 'rails_helper'

RSpec.describe Address, type: :model do
  let (:role) { create :role }
  let (:user) { create :user, :valid }
  let (:user_detail) { create :user_detail, :valid, role: role, user: user }
  let (:address) { build :address, :valid, user_detail: user_detail }
  it 'should create valid address with valid parameters' do
    expect(address.valid?).to eq(true)
  end
  it 'should not create address without city' do
    address.city = nil
    expect(address.valid?).to eq(false)
  end
  it 'should not create address without state' do
    address.state = nil
    expect(address.valid?).to eq(false)
  end
  it 'should not create address without pin' do
    address.pin = nil
    expect(address.valid?).to eq(false)
  end
end
