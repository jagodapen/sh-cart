Rails.application.routes.draw do
  resources :recipes
  resources :shopping_lists
  resources :products
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
