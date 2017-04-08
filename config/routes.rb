Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' 
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # :format 表示我们可以接受和响应对应的 format 请求。比如/products/1 响应的是 html， /products/1.json 响应的是 json。
  # 而 我们可以关闭这种响应，只需要： resources :products, format: false
  # 或者更改响应，只接受和响应 json，如：resources :products, format: 'json'
end
