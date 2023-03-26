Rails.application.routes.draw do
  get 'employee_contact_information/new'=> 'employee_contact_information#new', as: 'new_employee_contact_information'
  get 'employee_contact_information/destroy/:id'=> 'employee_contact_information#destroy', as: 'destroy_employee_contact_information'
  post 'employee_contact_information/create'=> 'employee_contact_information#create', as: 'create_employee_contact_information'
  # devise_for :employees
  devise_for :employees, controllers: {
  sessions: 'employees/sessions',
  registrations: 'employees/registrations'
}
  root "employee#index"
  #payment record related routes
  get 'payment_records/index'
  get 'payment_record/new/:id'=> 'payment_records#new', as: 'new_payment_record'
  post 'payment_record/create/:id'=> 'payment_records#create', as: 'create_payment_record'

  # subscription record related routes
  get 'subscription_records'=> 'subscription_records#index', as: 'subscription_records'
  get 'subscription_record/new'=> 'subscription_records#new', as: 'new_subscription_record'
  post 'subscription_record/create'=> 'subscription_records#create', as: 'create_subscription_record'
  get '/subscription_record/delete/:id' => 'subscription_records#destroy', as: 'destroy_subscription_record'
  get '/subscription_record/edit/:id' => 'subscription_records#edit', as: 'edit_subscription_record'
  get '/subscription_record/update/:id' => 'subscription_records#update', as: 'update_subscription_record'

  # subscription type related routes
  get '/subscription_types/delete/:id' => 'subscription_types#destroy', as: 'destroy_subscription_type'
  post '/subscription_types/update/:id' => 'subscription_types#update', as: 'update_subscription_type'
  get '/subscription_types/edit/:id' => 'subscription_types#edit', as: 'edit_subscription_type'
  resources :subscription_types
  
  # client related routes
  get '/clients' => 'clients#index', as: 'clients'
  get '/client_history' => 'clients#history', as: 'client_history'
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
