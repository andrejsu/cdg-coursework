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
    resources :comments, only: [:create]
  end
  resources :likes, only: [:create, :destroy]
end
