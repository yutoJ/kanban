Rails.application.routes.draw do

  unauthenticated :user do
    root to: 'pages#login'
  end

  authenticated :user do
    root to: 'projects#index'
  end

  get 'login', to: 'pages#login'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }


  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
    get 'leave', to: 'devise/registrations#destroy'

  end

  get 'mypage', to: 'users#mypage'
  get 'myproject', to: 'projects#myproject'

  resources :user, only: [:update]
  resources :projects do
    member do
      resources :columns, only: %i[new create]
    end
  end
end
