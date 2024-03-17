Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'orders/create'
  get 'orders/edit'
  get 'orders/update'
  get 'search/index'
  get 'items/index'
  get 'carts/show'
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root"home#index"
  resources :restaurants do
    post 'add_item', on: :member
  end
  resources :carts do
    post 'remove_item', on: :member
    post 'add_to_cart', on: :member
    post 'increment_cart_quantity', on: :member
    post 'decrement_cart_quantity', on: :member
  end
  get 'search', to: 'search#index'
  resources :addresses


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
