Rails.application.routes.draw do
  get 'subscription_type/index'
  get 'client/index'
  root "employee#index"
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
