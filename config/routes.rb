Rails.application.routes.draw do
  resources :comments, only: [:create, :edit, :update, :destroy]
  
  resources :posts, only: [:index, :show, :new, :create, :destroy]
  post '/posts/:id/like', to: "likes#create", as: "create_like"
  delete '/posts/:id/like', to: "likes#destroy", as: "delete_like"
  
  resources :users, except: :index
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  
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
