# frozen_string_literal: true

class StaffsController < ApplicationController
  before_action :find_staff, only: %i[show edit update destroy]

  def index
    if current_user.role == "admin"
      @staffs = current_company.users.all
    else
      @staffs = current_company.users.all.select{ |u| u.role != "admin" }
    end
  end

  def new
    @staff = current_company.users.new
  end

  def create
    @staff = current_company.users.new(staffs_params)
    if @staff.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @staff.update(staffs_params)
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

  def find_staff
    @staff = current_company.users.friendly.find(params[:id])
  end

  def staffs_params
    params.require(:user).permit(:staff_no, :name, :gender, :start_at, :email, :password, :password_confirmation, :job_title, :department, :company_id, :role)
  end
end
