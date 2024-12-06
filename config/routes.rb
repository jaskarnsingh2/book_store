Rails.application.routes.draw do
  # Cart routes
  post "carts/add_to_cart", to: "carts#add_to_cart", as: "add_to_cart"
  get "carts/show", to: "carts#show", as: "cart"
  delete "carts/remove", to: "carts#remove", as: "remove_from_cart"
  patch "carts/update", to: "carts#update", as: "update_cart"

  # Profile route
  get '/profile', to: 'users#profile', as: 'profile'

  # Shop page route (index for books)
  get "shop", to: "books#index"

  # Checkout routes
  get "checkout", to: "carts#checkout", as: "checkout" # Show the checkout page
  post "checkout", to: "carts#process_checkout", as: "process_checkout" # Handle checkout submission

  # Thank you page after successful checkout
  get "thank_you", to: "pages#thank_you", as: "thank_you"

  # Home page
  get "home/index"
  root "home#index"

  # Pages routes
  get "/about", to: "pages#show", defaults: { title: "About" }
  get "/contact", to: "pages#show", defaults: { title: "Contact" }

  # Orders routes
  resources :orders, only: [:index, :show, :new, :create] # Added orders resources

  # Devise routes for normal users (sign up, login, etc.)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
