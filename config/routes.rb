# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes
  resources :shopping_lists do
    post "send_email_now", on: :member
  end
  resources :products
  resources :shopping_list_emails, only: %i(new create edit update destroy)
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
