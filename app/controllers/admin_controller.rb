# frozen_string_literal: true

class AdminController < ApplicationController
  layout 'admin'
  def index
    @bulletins = current_company.bulletins
    @profiles = current_company.profiles
    vacations = if current_user.role == 'staff'
                  current_user.vacations
                else
                  current_company.vacations
                end
    vacation_orders = vacations.order(vacation_at: :asc)
    @vacation_result = vacation_orders.Pending + vacation_orders.Approved + vacation_orders.Rejected
  end
end
