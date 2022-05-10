Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: %i[index new create], module: :posts
    resources :reactions, only: %i[index create], module: :posts
  end

  resources :comments, only: %i[show edit update destroy] do
    resources :reactions, only: %i[index create], module: :comments
  end

  resources :reactions, only: %i[destroy]

  devise_for :users , controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: %i[index show] do
    resources :friendships, only: %i[index create update destroy]
  end
  root 'pages#home'
  get '/home', to: 'pages#home'
end
