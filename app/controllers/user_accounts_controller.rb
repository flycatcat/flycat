# frozen_string_literal: true

class UserAccountsController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = current_company.users.all
  end

  def new
    @user = current_company.users.new
  end

  def create
    @user = current_company.users.new(users_params)
    if @user.save
      redirect_to root_path, notice: '新增員工成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(users_params)
      redirect_to users_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to user_accounts_path, notice: '已刪除員工相關資訊'
  end

  private

  def find_user
    @user = current_company.users.friendly.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:company_id, :email, :password, :password_confirmation, :role)
  end
end
