Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # before_action :authenticate_user!

  scope :api, defaults: {format: :json} do
    resources :examples
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
    end
  end

  # Defines the root path route ("/")
  # root "home#index"
end
