# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :current_company

  def current_company
    return nil unless user_signed_in?
    @current_company ||= current_user.company
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for(_resource)
    root_path
  end

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit( :title,
                          :email,
                          :password,
                          :password_confirmation,
                          company_attributes: [:id, :title]
                        )
    end
  end

  private

  def user_not_authorized
    flash[:notice] = '你沒有檢視該頁面的權限!'
    redirect_to root_path
  end

  def check_permission
    available_roles = %w[admin staff manager]
    redirect_to root_path unless user_signed_in? && current_user.role.in?(available_roles)
  end
end
