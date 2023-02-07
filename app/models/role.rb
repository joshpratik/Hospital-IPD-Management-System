class Role < ApplicationRecord
  has_many :user_details
  validates :name, presence: true
end
