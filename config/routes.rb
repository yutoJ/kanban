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
    get 'leave', to: 'devise/registrations#destroy'
  end

  get 'mypage', to: 'users#mypage'
  get 'myproject', to: 'projects#myproject'

  resources :user, only: [:update] do
    resources :project_members, only: %i[create]
  end

  resources :projects do
    resources :columns, except: %i[index show]
    member do
      get 'invite'
    end
  end

  resources :column_positions, only: [:update]
  resources :cards, except: %i[index show] do
    member do
      get 'move'
    end
  end

  get 'invitation/accept/:id', to: 'project_members#accept', as: 'invitation'
end
