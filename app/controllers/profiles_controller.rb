# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @q = current_company.profiles.ransack(params[:q])
    @profiles = @q.result
    respond_to do |format|
      format.html
      format.csv { send_data @profiles.to_csv(['staff_no', 'name', 'gender', 'tel', 'start_at', 'department', 'job_title', 'user_id', 'company_id' ]) }
    end
  end

  def show; end

  def edit
    @work_shift_title = current_company.work_shifts.map(&:title)
  end

  def update
    if @profile.update(profiles_params)
      redirect_to profiles_path, notice: '新增成功'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, alert: '已刪除員工資訊'
  end

  private

  def find_profile
    @profile = current_company.profiles.friendly.find(params[:id])
  end

  def profiles_params
    params.require(:profile).permit(:staff_no, :name, :gender, :department, :tel, :start_at, :job_title, :email, :end_at, :work_shift_title)
  end
end
