# frozen_string_literal: true

Rails.application.routes.draw do
  match "/404", to: "application#not_found", via: :all
  match "/500", to: "application#internal_server_error", via: :all

  resources :companies, except: [:index, :destroy, :show]
  resources :profiles, except: [:show]
  resources :departments, except: [:show]
  resources :bulletins, except: []
  resources :user_accounts, only: [:new, :create]

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'home#index'
end
