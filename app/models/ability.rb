# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.user_detail.role.name.eql?('admin')
      can :manage, :all 
    elsif user.user_detail.role.name.eql?('staff')
      can :manage, UserDetail, Medicine, Treatment, Address
    end
  end
end
