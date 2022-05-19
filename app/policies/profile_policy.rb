class ProfilePolicy < ApplicationPolicy
  def index?
    update?
  end

  def new?
    update?
  end

  def create?
    update?
  end

  def edit?
    update?
  end

  def update?
    admin 
  end

  def destroy?
    admin || manager
  end
end
