Rails.application.routes.draw do
  devise_for :users

  root to: 'accounts#index'

  resources :accounts do
    resources :transactions, only: [:index, :new, :create]
    get '/ofx_import', to: 'accounts#ofx_import'
    post '/ofx_import', to: 'accounts#ofx_import_to_account'
  end

  resources :statistics, only: [:index]

  resources :transactions, only: [:edit, :update, :destroy]

  resources :categories

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
