Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    
    resources :posts
    
    resources :follows, only: [:get, :create, :update, :destroy]

    resources :feed, only: [:index]
    get '/feed/hashtag/:hashtag', to: 'feed#hashtag'

    resources :likes

    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
      get 'users/:id', to: 'users#show'
      get 'users/:id/followers', to: 'follows#followers'
      get 'users/:id/followings', to: 'follows#followings'
    end
  end
end
