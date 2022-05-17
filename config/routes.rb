Rails.application.routes.draw do
  resources :recipes
  resources :shopping_lists
  resources :products
  resources :shopping_list_emails, only: %i[new create edit update destroy]
  root 'home#index'
  post 'shopping_lists/email_job'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  # root 'articles#index'
end
