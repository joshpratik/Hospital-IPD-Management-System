class Medicine < ApplicationRecord
  has_many :treatments
  has_many :admissions, through: :treatments
  validates :name, :price presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
