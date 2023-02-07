require 'rails_helper'

RSpec.describe Role, type: :model do
  let (:role) { build :role }
  it 'should create valid role with valid parameters' do
    expect(role.valid?).to eq(true)
  end
  it 'should not create role without role name' do
    role.name = nil
    expect(role.valid?).to eq(false)
  end
end
