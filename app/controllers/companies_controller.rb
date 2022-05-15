# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :find_company, only: %i[edit update show destroy]
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show; end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to root_path, notice: '已刪除'
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:title, :vat_number, :person_in_charge, :address, :contact_person)
  end
end
