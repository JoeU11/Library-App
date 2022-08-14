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
    elsif params[:rentals?] #need to add overdue books as well
      cart = current_user.rented_books.where(status: "rented")
      cart.each do |carted_book|
        book = carted_book.book
        # book[:due_date] = # Finish after adding create rental action. Need field to be populated
        books << book
      end
    elsif params[:previous?]
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
    cart = current_user.rented_books.where(status: "carted")
    book = Book.find_by(id: params[:book_id])
    duplicate = false
    cart.each do |carted_book|
      if carted_book.book.title == book.title && carted_book.status == "carted"
        duplicate = true
      end
    end
    if duplicate
      render json: {message: "You may only have one copy of a book in your cart at a time"}, status: :unauthorized
    else
      rented_book = RentedBook.new(user_id: current_user.id, book_id: params[:book_id], status: "carted")
      rented_book.save
      render json: rented_book.as_json
    end
  end
end
