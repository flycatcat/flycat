class ReportPolicy < ApplicationPolicy
  def index?
    staff || manager || admin
  end
end
