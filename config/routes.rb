Rails.application.routes.draw do
  root to: 'feed_posts#index'

  devise_for :users
  resources :users, only: [:show]
  resources :follows, only: [:create, :destroy]

  resources :feed_posts, only: [:index] do
    resources :comments, only: [:create]
  end

  resources :posts, only: [:new, :create] do
    resources :comments, only: [:create]
  end
  resources :likes, only: [:create, :destroy]
end
