Rails.application.routes.draw do
  namespace :api do
    resources :register, only: [:show, :create]

    get 'users/current', to: 'users#current'
    resources :users, only: [:show, :update]
  end
end
