# frozen_string_literal: true

Rails.application.routes.draw do

  resources :companies, except: [:index, :destroy, :show]
  resources :profiles, except: [:show]
  resources :departments, except: [:show]
  resources :bulletins, except: []
  resources :user_accounts, only: [:index, :new, :create, :destroy]
  resources :punchcards
  
  resources :vacations do
    member do
      get :signoff
      post :signoff_completed
    end
  end
  resources :admin
  resources :work_shifts, param: :work_shift_id do
    member do
      resources :events, param: :event_id 
      get 'setting', to: 'work_shifts#setting', as: 'setting'
    end
  end
  

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'home#index'

  resources :orders, only: [:new, :create] do
    member do
      post :confirm
    end
  end  
end
