Rails.application.routes.draw do
  get 'index' => "events#index"

  get 'new' => "events#new", as: 'new_event'

  get 'edit/:id' => "events#edit", as: 'edit_event'

  get 'event/:id' => "events#show", as: 'event'

  get 'profile' => 'pages#profile'

  get 'privacy' => 'pages#privacy'

  get 'terms' => 'pages#terms'

  delete 'delete/:id' => "events#destroy", as: 'destroy_event'

  patch 'event/:id' => "events#update"

 root 'events#index'

 resources :events

 devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", confirmations: 'confirmations',
  registrations: 'registrations'}

  devise_scope :user do
    delete 'users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_sessions
    
    get 'login' => 'devise/sessions#new', as: 'login'

    get 'register' => 'devise/registrations#new', as: 'register'

    get 'profile/edit' => 'devise/registrations#edit', as: 'edit_user'

    get 'user/city' => 'registrations#city', as: 'add_city'

    get 'profile/password/edit' => 'registrations#edit_password', as: 'edit_password'    
  
    patch 'user/password' => 'registrations#update_password' 

    patch 'user/city' => 'registrations#update_city'
  end
end
