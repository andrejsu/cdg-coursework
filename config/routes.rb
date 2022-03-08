Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root to: 'static_pages#homepage'

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
