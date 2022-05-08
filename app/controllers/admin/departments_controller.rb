# frozen_string_literal: true

module Admin
  class DepartmentsController < Admin::BaseController
    before_action :find_departments, only: %i[edit update show destroy]

    def index
      @departments = Department.all
    end

    def new
      authorize :department
      @department = Department.new
    end

    def create
      authorize :department
      @department = Department.new(department_params)
      if @department.save
        redirect_to admin_departments_path, notice: '已新增部門'
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
        redirect_to root_path, notice: '更新成功'
      else
        render :edit
      end
    end

    def destroy
      authorize :department
      @department.destroy
      redirect_to admin_departments_path, notice: '已刪除部門'
    end

    private

    def department_params
      params.require(:department).permit(:department_name, :department_id)
    end

    def find_departments
      @department = Department.friendly.find(params[:id])
    end
  end
end
