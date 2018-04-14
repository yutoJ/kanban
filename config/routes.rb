Rails.application.routes.draw do

  root to: 'pages#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  get 'login', to: 'pages#login'

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end
end
