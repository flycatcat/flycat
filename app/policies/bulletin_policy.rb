# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    admin || manager || staff
  end

  def new?
    create?
  end

  def create?
    admin || manager
  end

  def edit?
    update?
  end

  def update?
    admin || manager
  end

  def destroy?
    admin || manager
  end
end
