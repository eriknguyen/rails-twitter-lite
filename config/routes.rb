Rails.application.routes.draw do

  root 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'heoo'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # Auto create 2 named routes:
  #     help_path -> '/help'
  #     help_url  -> 'root_url/help'

  get '/signup', to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
