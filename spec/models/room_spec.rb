require 'rails_helper'

RSpec.describe Room, type: :model do
  let (:room) { build :room }
  it 'should create valid room with valid parameters' do
    expect(room.valid?).to eq(true)
  end
  it 'should not create room without room type' do
    room.room_type = nil
    expect(room.valid?).to eq(false)
  end
  it 'should not create room without capacity' do
    room.capacity = nil
    expect(room.valid?).to eq(false)
  end
  it 'should not create room without charges' do
    room.charges = nil
    expect(room.valid?).to eq(false)
  end
end
