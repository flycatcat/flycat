# frozen_string_literal: true

class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[show edit update destroy signoff signoff_completed]

  def index
    @vacations = if current_user.role == 'staff'
                   current_user.vacations
                 else
                   current_company.vacations
                 end
  end

  def show; end

  def new
    @vacation = current_company.vacations.new
  end

  def edit; end

  def create
    @vacation = current_company.vacations.new(vacation_combine_id)
    params[:vacation][:hour] = params[:vacation][:hour].to_i
    if @vacation.save
      redirect_to vacations_path, notice: '假單申請成功.'
    else
      render :new
    end
  end

  def signoff; end

  def signoff_completed
    if @vacation.update(vacation_params)
      redirect_to vacations_path, notice: '簽核成功'
    else
      render :signoff
    end
  end

  def update
    if @vacation.update(vacation_params)
      redirect_to vacations_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @vacation.update(deleted_at: Time.now)
    redirect_to vacations_path, notice: '已刪除假單'
  end

  private

  def set_vacation
    @vacation = current_company.vacations.friendly.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:vacation_type, :vacation_at, :status, :reason, :company_id, :hour)
  end

  def vacation_combine_id
    vacation_params.merge(user_id: current_user.id)
  end
end
