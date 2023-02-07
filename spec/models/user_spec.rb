require 'rails_helper'
RSpec.describe User, type: :model do
  context 'when creating user ' do
    let(:user) { build :user, :valid }
    let(:inavlid_user) { build :user, :emailmissing }
    it 'should be valid user with valid parameters' do
      debugger
      expect(user.valid?).to eq(true)
    end
    it 'should not save user with email field missing' do
      expect(inavlid_user.valid?).to eq(false)
    end
    it 'should not valid without password' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end
end