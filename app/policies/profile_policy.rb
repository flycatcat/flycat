class ProfilePolicy < ApplicationPolicy
  def index?
    admin
  end

  def new?
    create?
  end

  def create?
    admin
  end

  def edit?
    update?
  end

  def update?
    admin 
  end

  def destroy?
    manager || admin
  end
end
