Rails.application.routes.draw do
  # before_action :authenticate_user!

  scope :api, defaults: {format: :json} do
    resources :examples
    resources :posts
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
      get 'users/:id', to: 'users#show'
    end
  end

  # Defines the root path route ("/")
  # root "home#index"
end
