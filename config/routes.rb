Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  namespace :api do
    namespace :v1 do
      # Route for requesting a password reset (POST)
      # resources :passwords, only: [:create, :update]
      resources :properties
      resources :reviews
      # Get the current logged-in user
      get "current_user", to: "users#get_current_user"
      # Referring to Api::V1::ConfirmationsController
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
