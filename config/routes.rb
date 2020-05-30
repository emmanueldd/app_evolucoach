Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'users/check_slug_availability/:slug', to: 'users#check_slug_availability', as: 'check_slug_availability'
  get 'inscription' , to: redirect('/users/sign_up')
  get 'app' , to: redirect('/dashboard')
  get ':user_id/orders/:id/availabilities' , to: 'interface/orders#availabilities', as: :order_availabilities

  resources :users, only: :index do
    resources :availabilities, only: :index, shallow: true
  end
  resources :programs, only: :show
  resources :packs, only: :show

  devise_for :clients, controllers: {
    # confirmations: 'clients/confirmations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords',
    registrations: 'clients/registrations',
    # omniauth_callbacks: "clients/omniauth_callbacks"
  }
  devise_for :users, controllers: {
    # confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    # omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :interface do
    root 'home#index'
    resources :clients, only: [:edit, :update]
    resources :programs, except: [:index]
    resources :orders, except: [:destroy]
    patch 'orders/:id/pay', to: 'orders#pay', as: 'pay_order'
  end

  namespace :dashboard do
    root 'home#index'
    resources :stats, only: :index
    resources :programs, shallow: true do
      resources :program_steps, path: :steps, as: :step
    end
    resources :user_has_clients, path: :crm
    resources :packs
    resources :ratings
    resources :availabilities
    resources :users
  end
  get ':id', to: 'users#show', as: 'user'
end
