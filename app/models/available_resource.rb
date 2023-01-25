class AvailableResource < ApplicationRecord
  belongs_to :room
  validates :available_capacity, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
