Rails.application.routes.draw do
  resources :comments, only: [:create, :edit, :update, :destroy]
  
  resources :posts
  patch '/posts', to: 'posts#index'
  post '/posts/:id/like', to: "likes#create", as: "create_like"
  delete '/posts/:id/like', to: "likes#destroy", as: "delete_like"
  
  resources :users
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  get '/users/:id/obsessions', to: 'users#obsessions', as: "obsessions"
  
  get '/', to: "sessions#show", as: 'dashboard'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  
  #######################################################################
  # THIS IS TEMPORARY. FOR DEVELOPMENT ONLY TO EASE RESETTING THE SESSION
  get '/logout', to: "sessions#destroy" 
  #######################################################################

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
