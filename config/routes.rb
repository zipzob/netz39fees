Netz39fees::Application.routes.draw do
  match 'fees/new' => 'fees#create', via: :post, as: 'fees_new'
  match 'fees/confirm/:token' => 'fees#confirm', via: :get
  match 'fees/edit/:token' => 'fees#edit', via: :get, as: 'fees_edit'
  match 'fees/edit/:token' => 'fees#update', via: :put

  match 'fees/edit_admin/:id' => 'fees#edit_admin', via: :get, as: 'fees_edit_admin'
  match 'fees/edit_admin/:id' => 'fees#update_admin', via: :put

  resources :fees, only: [:index, :new, :create, :destroy]

  resources :users, except: [:show]

  root :to => 'fees#new'
end
