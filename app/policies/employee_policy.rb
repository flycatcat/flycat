# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  def index?
    vendor || staff || trial
  end

  def new?
    vendor || trial
  end

  def create?
    new?
  end

  def edit?
    vendor || staff || trial
  end

  def update?
    vendor || staff || trial
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
