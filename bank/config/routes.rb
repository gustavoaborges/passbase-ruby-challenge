Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get 'users', to: 'users#index'
  post 'transfer', to: 'transfer#index'
end
