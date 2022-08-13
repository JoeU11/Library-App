class RentedBooksController < ApplicationController
  # This controller will serve as a 'cart'  as well as a catalogue of currently rented books. Index method is gonna be wild. 
  before_action :authenticate_user
  
  def index
    books = Array.new
    if params[:cart?]
      cart = current_user.rented_books.where(status: "carted")
      cart.each do |carted_book|
        book = carted_book.book
        books << book
      end
    elsif params[:current_rentals?]
      cart = current_user.rented_books.where(status: "rented")
      cart.each do |carted_book|
        book = carted_book.book
        # book[:due_date] = # Finish after adding create rental action. Need field to be populated
        books << book
      end
    elsif params[:previous_rentals?]
      cart = current_user.rented_books.where(status: "returned")
      cart.each do |carted_book|
        book = carted_book.book
        books << book
      end
    end
    render json: books.as_json
  end

  def destroy
    rented_book = RentedBook.find_by(id: params[:id])
    if current_user.id == rented_book.user_id && rented_book.status == "carted"
      rented_book.status = "removed"
      rented_book.save
      render json: {message: "This book has been removed from your cart"}
    else
      render json: {}, status: :unauthorized
    end
  end

  def create
    # can also add condition that a user must not have any overdue books
    current_rentals = current_user.rented_book.where(status: "rented")
    if current_rentals.count < 3 # add condition that book must be available
      rented_book = RentedBook.new(user_id: current_user.id, book_id: params[:book_id], status: "carted")
      # rented_book.save
      render json: rented_book.as_json
    else
      render json: {message: "You may only have up to three books rented at a time"}
    end
  end
end
