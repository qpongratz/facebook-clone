Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :users, only: %i[index show]
  root 'pages#home'
  get '/home', to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
