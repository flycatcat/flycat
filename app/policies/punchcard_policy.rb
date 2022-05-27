# frozen_string_literal: true

class PunchcardPolicy < ApplicationPolicy
  def index?
    staff || manager || admin
  end

  def create?
    staff || manager || admin
  end

  def new?
    staff || manager || admin
  end

  def edit?
    staff || manager || admin
  end

  def update?
    staff || manager || admin
  end

  def destroy?
    admin
  end
end
