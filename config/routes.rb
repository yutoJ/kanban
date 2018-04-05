Rails.application.routes.draw do
  root to: 'pages#index'
  get 'login', to: 'pages#login'
end
