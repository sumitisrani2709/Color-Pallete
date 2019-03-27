# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  resources :colors
  resources :palettes

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :palettes, only: [:create]
      resources :colors, only: [:index]
    end
  end
end
