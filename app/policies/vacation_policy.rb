# frozen_string_literal: true

class VacationPolicy < ApplicationPolicy
  def index?
    staff || manager || admin
  end

  def new?
    update?
  end

  def create?
    update?
  end

  def show?
    update?
  end

  def edit?
    update?
  end

  def update?
    staff || manager
  end

  def signoff
    manager || admin
  end

  def destroy?
    staff || manager || admin
  end
end
