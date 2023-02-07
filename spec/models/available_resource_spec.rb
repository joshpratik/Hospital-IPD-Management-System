require 'rails_helper'

RSpec.describe AvailableResource, type: :model do
  let (:room) { create :room}
  let (:available_resource) { build :available_resource, room: room}
  it 'should create valid available resource with valid parameters' do
    expect(available_resource.valid?).to eq(true)
  end
  it 'should not create available resource without available capacity' do
    available_resource.available_capacity = nil
    expect(available_resource.valid?).to eq(false)
  end
end
