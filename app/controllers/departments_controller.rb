# frozen_string_literal: true

class DepartmentsController < ApplicationController
  before_action :find_departments, only: %i[edit update show destroy]
  before_action :authenticate_user!
  
  def index
    @departments = current_company.departments
  end

  def new
    authorize :department
    @department = current_company.departments.new
  end

  def create
    authorize :department
    @department = current_company.departments.new(department_params)
    if @department.save
      redirect_to departments_path, notice: '已新增部門'
    else
      render :new
    end
  end

  def show; end

  def edit
    authorize :department
  end

  def update
    authorize :department
    if @department.update(department_params)
      redirect_to departments_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    authorize :department
    @department.destroy
    redirect_to departments_path, notice: '已刪除部門'
  end

  private

  def department_params
    params.require(:department).permit(:department_name)
  end

  def find_departments
    @department = current_company.departments.friendly.find(params[:id])
  end
end