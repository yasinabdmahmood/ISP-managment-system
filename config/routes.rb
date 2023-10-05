Rails.application.routes.draw do
  #Employees record related routes
  root "employee#index"
  post '/employee/update/:id'=> 'employee#update', as: 'update_employee'
  get 'employee_contact_information/new'=> 'employee_contact_information#new', as: 'new_employee_contact_information'
  get 'employee_contact_information/destroy/:id'=> 'employee_contact_information#destroy', as: 'destroy_employee_contact_information'
  post 'employee_contact_information/create'=> 'employee_contact_information#create', as: 'create_employee_contact_information'
  # devise_for :employees
  devise_for :employees, controllers: {
  sessions: 'employees/sessions',
  registrations: 'employees/registrations'
}
  
  #payment record related routes
  get 'payment_records/index'
  get 'payment_record/new/:id'=> 'payment_records#new', as: 'new_payment_record'
  get 'payment_record/destroy'=> 'payment_records#destroy', as: 'destroy_payment_record'
  post 'payment_record/create/:id'=> 'payment_records#create', as: 'create_payment_record'

  # subscription record related routes
  get 'subscription_records'=> 'subscription_records#index', as: 'subscription_records'
  get 'filtered_subscription_records'=> 'subscription_records#filter', as: 'filtered_subscription_records'
  get 'unpaid_subscription_records'=> 'subscription_records#unpaid', as: 'unpaid_subscription_records'
  get 'subscription_record/history'=> 'subscription_records#history', as: 'subscription_record_history'
  get 'subscription_record/new'=> 'subscription_records#new', as: 'new_subscription_record'
  post 'subscription_record/create'=> 'subscription_records#create', as: 'create_subscription_record'
  get '/subscription_record/delete/:id' => 'subscription_records#destroy', as: 'destroy_subscription_record'
  get '/subscription_record/edit/:id' => 'subscription_records#edit', as: 'edit_subscription_record'
  post '/subscription_record/update/:id' => 'subscription_records#update', as: 'update_subscription_record'
  post '/subscription_record/assign_employees' => 'subscription_records#assign_employees', as: 'assign_employees'

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
  get '/client_contact_information/destroy/:id'=> 'client_contact_information#destroy', as: 'destroy_client_contact_information'
  post '/client_contact_information/create'=> 'client_contact_information#create', as: 'create_client_contact_information'
 
  get 'employee/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get 'download', to: 'backups#download'
  get 'download_subscription_types_as_csv' => 'backups#download_subscription_types_as_csv', as: 'download_subscription_types_as_csv'
  get 'download_subscription_records_as_csv' => 'backups#download_subscription_records_as_csv', as: 'download_subscription_records_as_csv'
  get 'download_payment_records_as_csv' => 'backups#download_payment_records_as_csv', as: 'download_payment_records_as_csv'
  get 'download_clients_as_csv' => 'backups#download_clients_as_csv', as: 'download_clients_as_csv'

  #Activity related routes
  get 'activities/index' => 'activity#index', as: 'activirties'

  # Report related routes
  get 'reports/get_daily_report' => 'report#get_daily_report', as: 'get_daily_report'
  get 'reports/get_monthly_report' => 'report#get_monthly_report', as: 'get_monthly_report'
  
end
