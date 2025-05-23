Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "sessions#new"
  post "login" => "sessions#create", as: :login
  delete "logout", to: "sessions#destroy", as: :logout

  get "signup" => "users#new", as: :signup
  post "users" => "users#create", as: :users
  get "users/:id" => "users#show", as: :profile
  get "users/:id/edit" => "users#edit", as: :edit_profile
  patch "users/:id" => "users#update"
  delete "users/:id" => "users#destroy"

  get "feed" => "posts#index", as: :feed
  get "posts/new" => "posts#new", as: :new_post
  post "posts" => "posts#create", as: :posts
  get "posts/:id" => "posts#show", as: :post
  get "posts/:id/edit" => "posts#edit", as: :edit_post
  patch "posts/:id" => "posts#update"
  delete "posts/:id" => "posts#destroy", as: :delete_post
  resources :posts do
    resources :comments, only: [ :create ]
  end
  delete "comments/:id" => "comments#destroy", as: :delete_comment

  get "friend_requests" => "friend_requests#index", as: :friend_requests
  get "friend_requests/new" => "friend_requests#new", as: :new_friend_request
  post "friend_requests" => "friend_requests#create"
  delete "friend_requests/:id" => "friend_requests#destroy", as: :delete_friend_request

  get "friendships" => "friendships#index", as: :friendships
  post "friendships" => "friendships#create", as: :create_friendship
  delete "friendships/:id" => "friendships#destroy", as: :delete_friendship

  get "passwords/new" => "passwords#new", as: :new_password
  resources :passwords, param: :token
end
