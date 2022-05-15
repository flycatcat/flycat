# frozen_string_literal: true

Rails.application.routes.draw do
  match "/404", to: "application#not_found", via: :all
  match "/500", to: "application#internal_server_error", via: :all

  resources :companies
  resources :staffs
  resources :departments
  resources :bulletins


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home#index'
end
