class Treatment < ApplicationRecord 
  belongs_to :admission
  belongs_to :medicine
end
