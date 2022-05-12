Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: %i[index new create], module: :posts
    resources :reactions, only: %i[index create], module: :posts
  end

  resources :comments, only: %i[show edit update destroy] do
    resources :reactions, only: %i[index create], module: :comments
  end

  resources :reactions, only: %i[destroy]

  devise_for :users, controllers:
    { omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations' }

  resources :users, only: %i[index show] do
    resources :friendship_requests, only: %i[index]
    resources :friendships, only: %i[index]
  end

  resources :friendship_requests, only: %i[create destroy] do
    post 'accept', on: :member
  end
  resources :friendships, only: %i[create destroy]

  root 'pages#home'
  get '/home', to: 'pages#home'
end
