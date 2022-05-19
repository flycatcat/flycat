# frozen_string_literal: true

Rails.application.routes.draw do

  resources :companies, except: [:index, :destroy, :show]
  resources :profiles, except: [:show]
  resources :departments, except: [:show]
  resources :bulletins, except: []
  resources :user_accounts, only: [:index, :new, :create, :destroy]

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'home#index'
  get 'home/about'

  resources :orders, only: [:new, :create] do
    collection do
      post :confirm
    end
  end  
end