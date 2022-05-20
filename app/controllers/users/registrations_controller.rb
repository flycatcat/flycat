# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: [:update]
    before_action :configure_sign_up_params, only: [:create]

    def new
      super
    end

    def create
      super
    end

    def edit
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    private

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:title,
                           :vat_number,
                           :email,
                           :password,
                           :password_confirmation,
                           company_attributes: %i[id title vat_number user_id])
      end
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end

    def after_sign_up_path_for(resource)
      super(resource)
    end

    def after_inactive_sign_up_path_for(resource)
      super(resource)
    end
  end
end