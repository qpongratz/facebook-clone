Rails.application.routes.draw do
  resources :posts do
    resources :comments, shallow: true, module: :posts do
      resources :reactions, only: %i[index create], module: :comments
    end
    resources :reactions, only: %i[index create], module: :posts
  end

  resources :reactions, only: %i[destroy]

  devise_for :users
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[index create update destroy]
  end
  root 'pages#home'
  get '/home', to: 'pages#home'
end
