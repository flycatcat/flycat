# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  resources :companies, except: [:index, :destroy, :show]
  resources :profiles, except: [:show]
  resources :departments, except: [:show]
  resources :bulletins, except: []
  resources :user_accounts, only: [:index, :new, :create, :destroy]
  resources :punchcards
  resources :admin

  resources :vacations do
    member do
      get :signoff
      post :signoff_completed
    end
  end

  resources :work_shifts, param: :work_shift_id do
    member do
      resources :events, param: :event_id 
      get 'setting', to: 'work_shifts#setting', as: 'setting'
    end
  end
  
  resources :orders, only: [:new, :create] do
    member do
      post :confirm
      get :success
    end
  end
  
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  
  root 'home#index'
end
