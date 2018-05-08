Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'heoo'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # Auto create 2 named routes:
  #     help_path -> '/help'
  #     help_url  -> 'root_url/help'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login routes with sessions_controller
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      # use member to define routes eg. /users/1234/following and /users/3/followers
      get :following, :followers
    end
  end
  resources :microposts,      only: [:create, :destroy]
  resources :relationships,   only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
