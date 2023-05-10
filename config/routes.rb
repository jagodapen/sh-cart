# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes
  resources :shopping_lists
  resources :products
  resources :shopping_list_emails, only: %i(new create edit update destroy)
  root "home#index"
  post "shopping_lists/send_email_now"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
