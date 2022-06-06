# frozen_string_literal: true

Rails.application.routes.draw do
  
  get 'punchcard_setting/edit'
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  
  resources :companies, except: [:index, :destroy, :show]
  resources :departments, except: [:show]
  resources :user_accounts, only: [:index, :new, :create, :destroy]
  resources :punchcards, except: [:show]
  resources :punchcard_setting, except: [:show,:destroy,:index]
  resources :bulletins
  
  resources :profiles, except: [:show] do
    collection do
      post :export
    end
  end

  resources :vacations do
    member do
      get :signoff
      post :signoff_completed
    end
  end

  resources :admin
  resources :work_shifts do
    resources :events
    member do 
      get :setting
    end
  end

  resources :reports, only: [:index] do
    collection do
      post 'on_duties/:start_at/:end_at', to:'reports#on_duties'
      post 'vacations/:start_at/:end_at', to:'reports#vacations'
      post 'punchcards/:start_at/:end_at', to:'reports#punchcards'
    end
  end
  
  resources :orders, only: [:new, :create] do
    member do
      post :confirm
      get :success
    end
  end  

  namespace :api do
    namespace :v1 do
      resources :bulletins, only: [] do
        member do
          post :read
          delete :unread
        end
      end
    end
  end
  
  root 'home#index'

end
