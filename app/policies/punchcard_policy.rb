# frozen_string_literal: true

class PunchcardPolicy < ApplicationPolicy
  def index?
    admin || staff 
  end

  def create?
    index? 
  end

  def new?
    index?
  end

  def edit?
    admin
  end

  def update?
    index?
  end

  def destroy?
    admin
  end
end
