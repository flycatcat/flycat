# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  def index?
    admin || staff || trial
  end

  def new?
    admin || trial
  end

  def create?
    new?
  end

  def edit?
    admin || staff || trial
  end

  def update?
    admin || staff || trial
  end

  def destroy?
    new?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
