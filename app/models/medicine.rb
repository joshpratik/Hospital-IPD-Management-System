class Medicine < ApplicationRecord
  has_many :treatments
  has_many :admissions, through: :treatments
end
