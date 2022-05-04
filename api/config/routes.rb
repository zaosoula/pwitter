Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do    
    get '/feed', to: 'feed#index' # Get feed
    get '/feed/hashtag/:hashtag', to: 'feed#hashtag' # Get hashtag's feed
    get '/feed/user/:id', to: 'feed#user' # Get user's feed
    
    post '/posts', to: 'posts#create' # Create post
    delete '/posts', to: 'posts#destroy' # Delete post
    post '/posts/:id/like', to: 'likes#create' # Like a post
    delete '/posts/:id/like', to: 'likes#destroy' # Unlike a post

    devise_for :users, controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
    devise_scope :user do
      get 'users/current', to: 'sessions#show' # Get current user
      get 'users/:id', to: 'users#show' # Get user
      get 'users/:id/followers', to: 'follows#followers' # Get user's followers
      get 'users/:id/followings', to: 'follows#followings' # Get user's followings
      post 'users/:id/follow', to: 'follows#create' # Follow an user
      delete 'users/:id/follow', to: 'follows#destroy' # Unfollow an user
      get 'users/:id/feed', to: 'feed#user' # Get user's feed
    end
  end
end
