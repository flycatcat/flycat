# frozen_string_literal: true

class PunchcardPolicy < ApplicationPolicy
  def index?
    staff || manager || admin
  end

  def create?
    staff || manager
  end

  def new?
    create?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    admin
  end
end
