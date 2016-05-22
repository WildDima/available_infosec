Rails.application.routes.draw do
  root 'feeds#index'

  resources :articles, only: [:index, :show]
  namespace :api, defaults: {format: 'json'} do
    namespace :v1, defaults: {format: 'json'} do
      resources :articles, only: [:index, :show]
    end
  end

  end
