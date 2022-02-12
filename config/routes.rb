Rails.application.routes.draw do
  devise_for :users

  root to: 'accounts#index'

  resources :accounts do
    resources :transactions, only: [:index, :new, :create]
    get '/ofx_import', to: 'accounts#ofx_import'
    post '/ofx_import', to: 'accounts#ofx_import_to_account'
  end

  resources :categories do
    resources :subcategories, only: [:new, :create]
  end

  resources :statistics, only: [:index]
  resources :transactions, only: [:edit, :update, :destroy]
  resources :subcategories, only: [:edit, :update, :destroy]
end
