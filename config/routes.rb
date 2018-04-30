Rails.application.routes.draw do
  devise_for :users

  resources :exchange

  root 'exchange#index'
end
