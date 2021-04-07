Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  get "user/:id/follow_users" => "users#follow_users", as: "follow_users"
  get "user/:id/follower_users" => "users#follower_users", as: "follower_users"

  get "search" => "searches#search"

end
