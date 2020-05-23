Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'users/check_slug_availability/:slug', to: 'users#check_slug_availability', as: 'check_slug_availability'
  get 'inscription' , to: redirect('/users/sign_up')

  resources :users, only: :index
  resources :programs, only: :show

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
    resources :orders, except: [:destroy]
  end

  namespace :dashboard do
    root 'home#index'
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
