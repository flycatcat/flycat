class CompaniesController < ApplicationController
  before_action :find_company, only: [:edit, :update, :show, :destroy]
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.new
  end

  def create
    @company = Company.new
    if @company.save(company_params)
      redirect_to companies_path, notice: "新增成功"
    else
      render :new
    end
  end

  def show
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to root_path, notice: "已刪除"
  end

  private
  def find_company
    @company = company.find(params[:id])
  end

  
  def company_params
      params.require(:company).permit(:company_title, :vat_number ,:principal, :address, :linkman, :email)
  end
end
