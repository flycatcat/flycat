# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'].except!(:extra))
      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_path
      end
    end

    def failure
      flash.now[:alert] = '無法獲得驗證！'
      redirect_to root_path
    end

  end
end