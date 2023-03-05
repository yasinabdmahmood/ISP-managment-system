Rails.application.routes.draw do
  root "employee#index"

  get 'payment_record/index'

  get 'subscription_record/index'


  get '/subscription_types/delete/:id' => 'subscription_types#destroy', as: 'destroy_subscription_type'
  post '/subscription_types/update/:id' => 'subscription_types#update', as: 'update_subscription_type'
  get '/subscription_types/edit/:id' => 'subscription_types#edit', as: 'edit_subscription_type'
  resources :subscription_types
 
  get 'client/index'
 
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
