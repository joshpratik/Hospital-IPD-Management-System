require 'rails_helper'

RSpec.describe Medicine, type: :model do
  let (:medicine) { build :medicine }
  it 'should create valid medicine with valid parameters' do
    expect(medicine.valid?).to eq(true)
  end
  it 'should not create medicine without medicine name' do
    medicine.name = nil
    expect(medicine.valid?).to eq(false)
  end
  it 'should not create medicine without medicine name' do
    medicine.price = nil
    expect(medicine.valid?).to eq(false)
  end
end