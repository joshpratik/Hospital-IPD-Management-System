class Address < ApplicationRecord
  belongs_to :user_detail
  validates :city, :state, :pin, presence: true
  validates :pin, numericality: { only_integer: true },length: { is: 6 }
end
