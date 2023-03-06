Rails.application.routes.draw do
  root "employee#index"

  get 'payment_record/index'

  # subscription record related routes
  get 'subscription_records'=> 'subscription_records#index', as: 'subscription_records'
  get 'subscription_record/new'=> 'subscription_records#new', as: 'new_subscription_record'
  post 'subscription_record/create'=> 'subscription_records#create', as: 'create_subscription_record'

  # subscription type related routes
  get '/subscription_types/delete/:id' => 'subscription_types#destroy', as: 'destroy_subscription_type'
  post '/subscription_types/update/:id' => 'subscription_types#update', as: 'update_subscription_type'
  get '/subscription_types/edit/:id' => 'subscription_types#edit', as: 'edit_subscription_type'
  resources :subscription_types
  
  # client related routes
  get '/clients' => 'clients#index', as: 'clients'
  get '/client/new' => 'clients#new', as: 'new_client'
  post '/client/create' => 'clients#create', as: 'create_client'
  get '/client/delete/:id' => 'clients#destroy', as: 'destroy_client'
  post '/client/update/:id' => 'clients#update', as: 'update_client'
  get '/client/edit/:id' => 'clients#edit', as: 'edit_client'
 
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
