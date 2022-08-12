Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/books" => "books#index"
  get "/books/:id" => "books#show"


  get "/categories" => "categories#index"

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"
end
