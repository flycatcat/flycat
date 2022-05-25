# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: [:update]
    before_action :configure_sign_up_params, only: [:create]

    private

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:title,
                           :ubn,
                           :email,
                           :password,
                           :password_confirmation,
                           company_attributes: %i[id title ubn user_id])
      end
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end
  end
end
