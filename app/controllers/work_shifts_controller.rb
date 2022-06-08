# frozen_string_literal: true

class WorkShiftsController < ApplicationController
  before_action :find_work_shift, only: %i[edit update destroy setting regular_holiday]

  def index
    @work_shifts = current_company.work_shifts
  end

  def new
    @work_shift = current_company.work_shifts.new
  end

  def create
    @work_shift = current_company.work_shifts.new(work_shift_params)
    if @work_shift.save
      redirect_to work_shifts_path, notice: '班表新增成功'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @work_shift.update(work_shift_params)
      redirect_to work_shifts_path, notice: '班表更新成功'
    else
      render :edit
    end
  end

  def destroy
    @work_shift.destroy
    redirect_to work_shifts_path, alert: '已刪除班表'
  end

  def setting
    @on_duty_staff = ["請選擇"]+current_company.profiles.where(work_shift_title: WorkShift.find(params[:id]).title).map{|p| p.staff_no+'_'+p.name}
  end
      
  private

  def work_shift_params
    params.require(:work_shift).permit(:title, :kind)
  end

  def find_work_shift
    @work_shift = WorkShift.find(params[:id])
  end
end
