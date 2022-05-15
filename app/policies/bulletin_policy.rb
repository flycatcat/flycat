# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    admin || staff 
  end

  def create?
    admin 
  end

  def new?
    admin 
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
