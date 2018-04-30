Rails.application.routes.draw do
  devise_for :users

  resources :exchanges

  root 'exchanges#index'
end
