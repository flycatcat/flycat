class BulletinPolicy < ApplicationPolicy

  def index?
    vendor || staff || trial
  end

  def create?
    vendor || trial
  end

  def new?
    vendor || trial
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
