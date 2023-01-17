class UserDetail < ApplicationRecord
  belongs_to :role
  has_one :user
  has_one :address
end
