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
