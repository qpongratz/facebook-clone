Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :users, only: %i[index show] do
    resources :friendships, shallow: true
  end
  root 'pages#home'
  get '/home', to: 'pages#home'
end
