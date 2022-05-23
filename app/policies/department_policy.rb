# frozen_string_literal: true

class DepartmentPolicy < ApplicationPolicy
  def index?
    manager || admin
  end

  def new?
    create?
  end

  def create?
    manager || admin
  end

  def edit?
    update?
  end

  def update?
    manager || admin
  end

  def destroy?
    index?
  end

end
