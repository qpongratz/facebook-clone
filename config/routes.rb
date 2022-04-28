Rails.application.routes.draw do
  resources :friendships, only: %i[new create destroy]
  resources :posts
  devise_for :users
  resources :users, only: %i[index show]
  root 'pages#home'
  get '/home', to: 'pages#home'
end
