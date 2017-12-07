Rails.application.routes.draw do
  get 'index' => "events#index"

  get 'new' => "events#new", as: 'new_event'

  post 'new' => 'events#new'

  get 'edit/:id' => "events#edit", as: 'edit_event'

  post 'edit/:id' => 'events#edit'

  get 'event/:id' => "events#show", as: 'event'

  get 'profile' => 'pages#profile'

  get 'privacy' => 'pages#privacy'

  get 'terms' => 'pages#terms'

  delete 'delete/:id' => "events#destroy", as: 'destroy_event'

  patch 'event/:id' => "events#update"

  get 'confirmed' => 'pages#confirmed', as: 'confirmed'

 root 'events#index'

 resources :events

 devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", confirmations: 'confirmations',
  registrations: 'registrations', passwords: 'passwords' }

  devise_scope :user do
    
    get 'login' => 'devise/sessions#new', as: 'login'

    post 'login' => 'devise/sessions#create'

    get 'register' => 'devise/registrations#new', as: 'register'

    post 'register' => 'devise/registrations#create'

    get 'profile/edit' => 'devise/registrations#edit', as: 'edit_user'

    get 'user/city' => 'registrations#city', as: 'add_city'

    get 'profile/password/edit' => 'registrations#edit_password', as: 'edit_password'

    patch 'user/password' => 'registrations#update_password' 

    patch 'user/city' => 'registrations#update_city'

    get 'password/reset' => 'passwords#new', as: 'password_reset'

    post 'password/reset' => 'passwords#reset_password'

    post 'email/confirmations' => 'confirmations#send_confirmation', as: 'send_reconfirmation'

    get 'email/confirmations' => 'confirmations#send_confirmation'

  end
end
