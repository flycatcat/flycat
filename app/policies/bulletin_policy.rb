# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    staff || manager || admin
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
    manager || admin
  end
end
