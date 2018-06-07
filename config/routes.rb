Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  
  # routes for pages (get)
  # get 'static_pages/home'

  # 1) typical route
  # get 'static_pages/help'
  # 2) change routes (static_pages/help -> /help). Use like 'help_path'. 'help' of help_path comes from '/help'
  # GETリクエストが /help に送信されたときにStaticPagesコントローラーのhelpアクションを呼び出してくれる
  # get '/help', to: 'static_pages#help'
  # 3) can change named route with as: option. Use like 'helf_path'
  # get  '/help', to: 'static_pages#help', as: 'helf'
  get '/help', to: 'static_pages#help'

  #get 'static_pages/about'
  get '/about', to: 'static_pages#about'

  #get 'static_pages/contact'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Add the following to add URL's like /users/1 
  # this was generated automatically in prev projects
  # this makes REST architechture
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
end
