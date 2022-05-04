Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  devise_for :users
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[index create update destroy]
  end
  root 'pages#home'
  get '/home', to: 'pages#home'
end
