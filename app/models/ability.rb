# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.user_detail.role.name.eql?('admin')
      can :manage, :all 
    elsif user.user_detail.role.name.eql?('staff')
      can :manage, UserDetail
      can :manage, Admission
      can :manage, Address
      can :manage, Medicine
      can :manage, Treatment
    end
  end
end
