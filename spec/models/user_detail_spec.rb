require 'rails_helper'

RSpec.describe UserDetail, type: :model do
  let (:role) { create :role }
  let (:user) { create :user, :valid }
  let (:user_detail) { build :user_detail, :valid, role: role, user: user }
  it 'should create valid user_detail with valid parameters' do
    expect(user_detail.valid?).to eq(true)
  end
  it 'should not create user_detail without first name' do
    user_detail.first_name = nil
    expect(user_detail.valid?).to eq(false)
  end
  it 'should not create user_detail without date of birth' do
    user_detail.date_of_birth = nil
    expect(user_detail.valid?).to eq(false)
  end
  it 'should not create user_detail without gender' do
    user_detail.gender = nil
    expect(user_detail.valid?).to eq(false)
  end
  it 'should not create user_detail without phone number' do
    user_detail.phone_no = nil
    expect(user_detail.valid?).to eq(false)
  end
  it 'should not create user_detail with invalid phone number' do
    user_detail.phone_no = '123456'
    expect(user_detail.valid?).to eq(false)
  end
end
