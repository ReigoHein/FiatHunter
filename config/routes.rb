Rails.application.routes.draw do
  devise_for :users
  get 'market/index'
  post 'market/details'

  root 'market#index'
end
