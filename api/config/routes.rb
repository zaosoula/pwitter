Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do    
    get '/feed', to: 'feed#index'
    get '/feed/hashtag/:hashtag', to: 'feed#hashtag'
    get '/feed/user/:id', to: 'feed#user'
    
    resources :follows, only: [:get, :create, :update, :destroy]


    resources :posts
    post '/posts/:id/like', to: 'likes#create'
    delete '/posts/:id/like', to: 'likes#destroy'


    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
      get 'users/:id', to: 'users#show'
      get 'users/:id/followers', to: 'follows#followers'
      get 'users/:id/followings', to: 'follows#followings'
      get 'users/:id/feed', to: 'feed#user'
    end
  end
end
