Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin_interface do
    get 'connect_as_this_client/:id', to: 'clients#connect_as', as: 'connect_as_this_client'
    get 'connect_as_this_user/:id', to: 'users#connect_as', as: 'connect_as_this_user'
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'users/check_slug_availability/:slug', to: 'users#check_slug_availability', as: 'check_slug_availability'
  get ':id/creneaux', to: 'users#calendly', as: 'user_calendly'
  get 'inscription' , to: redirect('/users/sign_up')
  get 'app' , to: redirect('/dashboard')
  get ':user_id/orders/:id/availabilities' , to: 'interface/orders#availabilities', as: :order_availabilities
  get 'continue_to_user/:id' , to: 'users#user_important', as: :user_important
  get 'orders/alma_confirm' , to: 'interface/orders#alma_confirm', as: :alma_confirm
  get 'orders/alma_cancel' , to: 'interface/orders#alma_cancel', as: :alma_cancel
  get 'client/authenticate' , to: 'clients#authenticate_client', as: :authenticate_client
  get 'program/download' , to: 'programs#download', as: :download_program

  resources :users, only: :index do
    resources :availabilities, only: :index, shallow: true
  end

  resources :programs, only: :show
  resources :packs, only: :show
  resources :online_offers, path: 'suivi', only: :show

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
    resources :orders, except: [:destroy, :show]
    resources :orders, only: :show, path: 'payment_completed', as: :payment_completed
    get 'orders/:id/payment_page', to: 'orders#payment', as: 'order_payment'
    patch 'orders/:id/pay', to: 'orders#pay', as: 'pay_order'
    post 'orders/:id/pay_alma', to: 'orders#pay_alma', as: 'pay_order_via_alma'
  end

  namespace :dashboard do
    root 'home#index'
    resources :payment_infos, only: [:index, :create, :edit, :update]
    get 'payment_info/redirect_uri', to: 'payment_infos#redirect_uri', as: 'payment_info_redirect_uri'
    resources :stats, only: [:index]
    resources :orders
    resources :crm, only: [:index, :show], shallow: true do
      resources :crm_comments, as: :comment, path: :comments
    end
    get 'stats/traffic', to: 'stats#traffic', as: 'stats_traffic'
    get 'stats/goal', to: 'stats#goal', as: 'stats_goal'
    get 'stats/params', to: 'stats#tracking_params', as: 'stats_params'
    get 'stats/get_charts', to: 'stats#get_charts', as: 'stats_get_charts'
    resources :programs, shallow: true do
      resources :program_steps, path: :steps, as: :step
    end
    resources :online_offers, path: 'suivi'
    resources :packs
    resources :ratings
    resources :availabilities
    resources :users
    resources :stripe_payment_methods
    resources :subscriptions do
      member do
        get 'cancel'
      end
      collection do
        post 'create_subscription'
      end
    end
  end
  get ':id', to: 'users#show', as: 'user'
end
