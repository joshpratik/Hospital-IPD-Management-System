class Treatment < ApplicationRecord 
  belongs_to :admission
  belongs_to :medicine
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
