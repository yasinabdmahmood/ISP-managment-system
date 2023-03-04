Rails.application.routes.draw do
  root "employee#index"

  get 'payment_record/index'

  get 'subscription_record/index'

  resource :subscription_types
  
  get '/subscription_types/index'
  get '/subscription_types/new'
  get '/subscription_types/:id' => 'subscription_types#destroy', as: 'destroy_subscription_types'
  post 'subscription_types/create'
 

  get 'client/index'
 
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
