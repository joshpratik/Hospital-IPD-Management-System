class Room < ApplicationRecord
  has_one :available_resource
  validates :room_type, :charges, :capacity, presence: true
  validates :charges, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }
end
