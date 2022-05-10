# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # skip_before_action :verify_authenticity_token
    # # 新增此段Google第三方登入的方法
    def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_path
      end
    end

    def github
      @user = User.create_from_provider_data(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_path
      end
    end
    # Github登入
    # def github
    #   handle_auth 'Github'
    # end

    # def self.handle_auth(kind)
    #   @user = User.from_omniauth(request.env['omniauth.auth'])
    #   if @user.persisted?
    #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
    #     sign_in_and_redirect @user, event: :authentication
    #   else
    #     session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
    #     redirect_to new_user_registration_path, alert: @user.errors.full_messages.join("\n")
    #   end
    # end

    def failure
      redirect_to root_path, notice: 'Failure. Please try again'
    end
  end
end
