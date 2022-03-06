Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root to: 'public#homepage'

  resources :posts, only: [:index, :new, :create] do
    member do
      patch 'like', to: 'posts#like'
    end
  end
end
