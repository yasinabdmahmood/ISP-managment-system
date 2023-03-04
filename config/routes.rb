Rails.application.routes.draw do
  root "employee#index"

  get 'payment_record/index'

  get 'subscription_record/index'
  
  get '/subscription_type/index'
  get '/subscription_type/new'
  get '/subscription_type/:id' => 'subscription_type#destroy', as: 'destroy_subscription_type'
  post 'subscription_type/create'
 

  get 'client/index'
 
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
