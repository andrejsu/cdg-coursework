Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  resources :follows, only: [:create, :destroy]

  resources :posts, only: [:index, :new, :create] do
    member do
      patch 'like', to: 'posts#like'
    end
    resources :comments, only: [:create]
  end
end
