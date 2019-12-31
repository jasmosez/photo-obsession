Rails.application.routes.draw do
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :users, except: :index
  post '/posts/:id/like', to: "likes#create", as: "create_like"
  delete '/posts/:id/like', to: "likes#destroy", as: "delete_like"
  get '/', to: "sessions#show"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  post '/logout', to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
