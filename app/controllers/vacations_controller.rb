# frozen_string_literal: true

class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[show edit update destroy signoff signoff_completed]
  before_action :correct_user, only: %i[edit update]
  before_action :unable_signoff, only: %i[signoff]

  def index
    vacations = if current_user.role == 'staff'
                  current_user.vacations.order(vacation_at: :asc)
                else
                  current_company.vacations.order(vacation_at: :asc)
                end
    @vacation_result = vacations.pending + vacations.approved + vacations.rejected
  end

  def show; end

  def new
    @vacation = Vacation.new
  end

  def edit
    redirect_to vacations_path, notice: '不可編輯，簽核已完成' if @vacation.status != 'pending'
  end

  def create
    @vacation = current_company.vacations.new(vacation_params.merge(user: current_user))
    if @vacation.save
      redirect_to vacations_path, notice: t('.假單申請成功')
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
    @vacation.destroy
    redirect_to vacations_path, notice: '已刪除假單'
  end

  private

  def correct_user
    set_vacation
    redirect_to vacations_path, notice: '沒有編輯權限！' if @vacation.user != current_user
  end

  def unable_signoff
    set_vacation
    redirect_to vacations_path, notice: '不能簽核本人假單！' if @vacation.user == current_user
  end

  def set_vacation
    @vacation = current_company.vacations.friendly.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:vacation_type, :vacation_at, :status, :reason, :hour, :proof)
  end
end
