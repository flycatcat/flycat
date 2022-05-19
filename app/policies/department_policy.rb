# frozen_string_literal: true

class DepartmentPolicy < ApplicationPolicy
  def index?
    admin || manager
  end

  def new?
    create?
  end

  def create?
    admin || manager
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

end
