class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  belongs_to :user_detail
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  validates :email, :password, presence: true

  def jwt_payload
    super
  end
end
