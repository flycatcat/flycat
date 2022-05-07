# frozen_string_literal: true

class StaffsController < ApplicationController
  before_action :find_staff, only: %i[show edit update destroy]

  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @staff.update(staff_params)
      redirect_to staffs_path, notice: '新增成功'
    else
      render :edit
    end
  end

  def destroy
    @staff.destroy
    redirect_to staffs_path, notice: '已刪除員工資訊'
  end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:name, :tel, :start_at, :staff_no, :gender, :department_id)
  end
end
