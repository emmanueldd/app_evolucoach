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
    resources :stats, only: [:index]
    resources :crm, only: [:index, :show], shallow: true do
      resources :crm_comments, as: :comment, path: :comments
    end
    get 'stats/traffic', to: 'stats#traffic', as: 'stats_traffic'
    get 'stats/goal', to: 'stats#goal', as: 'stats_goal'
    get 'stats/get_charts', to: 'stats#get_charts', as: 'stats_get_charts'
    resources :programs, shallow: true do
      resources :program_steps, path: :steps, as: :step
    end
    # resources :user_has_clients, path: :crm, as: :crm
    resources :packs
    resources :ratings
    resources :availabilities
    resources :users
  end
  get ':id', to: 'users#show', as: 'user'
end
