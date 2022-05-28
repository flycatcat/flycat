# frozen_string_literal: true

class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[show edit update destroy signoff signoff_completed]
  before_action :correct_user, only: %i[edit update]
  before_action :unable_signoff, only: %i[signoff]

  def index
    if current_user.role == "staff"
      vacations = current_user.vacations
    else
      vacations = current_company.vacations
    end
    vacation_orders = vacations.order(vacation_at: :asc)
    @vacation_result = vacation_orders.Pending + vacation_orders.Approved + vacation_orders.Rejected
  end

  def show; end

  def new
    @vacation = current_company.vacations.new
  end

  def edit
      redirect_to vacations_path, notice: '不可編輯，簽核已完成' if @vacation.status != "Pending"
  end

  def create
    @vacation = current_company.vacations.new(vacation_combine_id)
    params[:hour] = params[:hour].to_i
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
    @vacation.update(deleted_at: Time.now)
    redirect_to vacations_path, notice: '已刪除假單'
  end

  private

  def correct_user     
    @vacation = current_company.vacations.friendly.find(params[:id])
    if current_user.id != @vacation.user_id
      redirect_to vacations_path, notice: "沒有編輯權限！" 
    else
      @vacation = current_company.vacations.friendly.find(params[:id])
    end  
  end

  def unable_signoff
    @vacation = current_company.vacations.friendly.find(params[:id])
    if current_user.id == @vacation.user_id
      redirect_to vacations_path, notice: "不能簽核本人假單！" 
    else
      @vacation = current_company.vacations.friendly.find(params[:id])
    end 
  end

  def set_vacation
    @vacation = current_company.vacations.friendly.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:vacation_type, :vacation_at, :status, :reason, :hour)
  end

  def vacation_combine_id
    vacation_params.merge(user_id: current_user.id)
  end
end
