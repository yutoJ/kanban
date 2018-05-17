Rails.application.routes.draw do

  unauthenticated :user do
    root to: 'pages#login'
  end

  authenticated :user do
    root to: 'projects#index'
  end

  get 'login', to: 'pages#login'
  get 'notification', to: 'pages#notification'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
    get 'leave', to: 'users/registrations#destroy'
  end

  get 'mypage', to: 'users#mypage'
  get 'myproject', to: 'projects#myproject'

  resources :user, only: %i[update destroy] do
    resources :invitations, only: %i[create]
  end

  resources :projects do
    resources :columns, except: %i[index show]
    member do
      get 'invite'
      get 'logs'
    end
  end

  resources :column_positions, only: [:update]
  resources :cards, except: %i[index show] do
    member do
      get 'move'
    end
  end

  get 'invitations/:id/accept', to: 'invitations#accept', as: 'invitation'
end
