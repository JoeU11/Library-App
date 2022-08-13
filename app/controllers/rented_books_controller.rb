class RentedBooksController < ApplicationController
  # This controller will serve as a 'cart'  as well as a catalogue of currently rented books. Index method is gonna be wild. 
  before_action :authenticate_user
  
  def index
    if params[:show_cart?]
      cart = current_user.rented_books.where(status: "carted")
      books = Array.new
      cart.each do |carted_book|
        book = carted_book.book
        books << book
      end
    elsif params[:current_rentals?]
      cart = current_user.rented_books.where(status: "rented")
      books = Array.new
      cart.each do |carted_book|
        book = carted_book.book
        # book[:due_date] = # Finish after adding create rental action. Need field to be populated
        books << book
      end
    elsif params[:previous_rentals?]
      cart = current_user.rented_books.where(status: "returned")
      books = Array.new
      cart.each do |carted_book|
        book = carted_book.book
        books << book
      end
    end
    render json: books.as_json
  end
end
