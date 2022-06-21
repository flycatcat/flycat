# frozen_string_literal: true

class UserAccountsController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @users = current_company.users.reject { |u| u.role == 'admin' } if current_user.role == 'admin'
  end

  def new
    @work_shift_title = current_company.work_shifts.map(&:title)
    if current_company.orders.where(status: 'SUCCESS').any? || current_company.profiles.size < 5
      @user = current_company.users.new
    else
      redirect_to profiles_path, alert: '請儲值升級開通權限'
    end
  end

  def create
    @work_shift_title = current_company.work_shifts.map(&:title)
    @user = current_company.users.new(users_params)
    if @user.save
      redirect_to profiles_path, notice: '已成功新增員工資訊'
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
    redirect_to user_accounts_path, alert: '已刪除員工相關資訊'
  end

  private

  def find_user
    @user = current_company.users.friendly.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role,
                                 profile_attributes: %i[id staff_no name gender department tel start_at job_title end_at user_id company_id  work_shift_title])
  end
end
