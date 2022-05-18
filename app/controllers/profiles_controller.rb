# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update destroy]
  # before_action :email_difference, only: %i[new]

  def index
    @profiles = if current_user.role == 'admin'
                current_company.profiles.all.reject { |u| u.id == current_company.id }
                else
                current_company.profiles.all.reject { |u| u.role == 'admin' }
                end
  end

  def new
    @profile = current_company.profiles.new
    email_difference
  end

  def create
    @staff_profiles = current_company.users.where(role: %w[staff manager]).map{ |u| u.email}
    @profile = current_company.profiles.new(params_combine_id)

    if @profile.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @profile.update(profiles_params)
      redirect_to profiles_path, notice: '新增成功'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice: '已刪除員工資訊'
  end

  private

  def email_difference
    @user_email = current_company.users.where(role: %w[staff manager]).map(&:email)
    @profile_email = current_company.profiles.where(role: %w[staff manager]).map(&:email)
    @profiles = @user_email - @profile_email
  end

  def find_profile
    @profile = current_company.profiles.friendly.find(params[:id])
  end

  def profiles_params
    params.require(:profile).permit(:staff_no, :name, :gender, :department, :company_id, :role, :tel, :start_at, :job_title, :email)
  end

  def params_combine_id
    profiles_params.merge(user_id: User.find_by(email: params['profile']['email']).id)
  end
end
