# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_locale

  helper_method :current_company

  def current_company
    @current_company = current_user.company
  end

  private

  def set_locale
    session[:locale] = params[:locale] if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def user_not_authorized
    flash[:notice] = '你沒有檢視該頁面的權限!'
    redirect_to root_path
  end

  def after_sign_in_path_for(_resource)
    admin_index_path
  end
end
