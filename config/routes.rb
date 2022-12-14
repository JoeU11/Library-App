Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/books" => "books#index"
  post "/books" => "books#create"
  patch "/books/:id" => "books#update"
  get "/books/:id" => "books#show"
  delete "/books/:id" => "books#destroy"

  get "/categories" => "categories#index"

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  get "/rented_books" => "rented_books#index" # change rented_books url to cart once working and add param for librarian to choose to see all

  delete "/rented_books/:id" => "rented_books#destroy"

  post "/rented_books" => "rented_books#create"

  post "/rentals" => "rentals#create"
end
