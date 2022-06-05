class WorkShiftPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    create?
  end

  def create?
    manager || admin
  end

  def show?
    manager || admin
  end

  def edit?
    update?
  end

  def update?
    manager || admin
  end

  def destroy?
    manager || admin
  end
end
