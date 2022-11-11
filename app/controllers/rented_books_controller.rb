class RentedBooksController < ApplicationController
  # This controller will serve as a 'cart'  as well as a catalogue of currently rented books. Index method is gonna be wild.
  before_action :authenticate_user

  def index
    books = Array.new
    if params[:cart]
      @books = current_user.rented_books.where(status: "carted")
      # cart.each do |carted_book|
      #   book = carted_book.book
      #   books << book
      # end
    elsif params[:rented]
      @books = current_user.rented_books.where(status: "rented")
      # rentals.each do |rented_book|
      #   book = rented_book.book
      #   books << book
      #   books << rented_book.due_date
      # end
    elsif params[:previous]
      @books = current_user.rented_books.where(status: "returned")
      # returns.each do |returned_book|
      #   book = returned_book.book
      #   books << book
      # end
    end
    render template: "rented_books/index"
  end

  def destroy
    rented_book = RentedBook.find_by(id: params[:id])
    if current_user.id == rented_book.user_id && rented_book.status == "carted"
      rented_book.status = "removed"
      rented_book.save
      render json: { message: "This book has been removed from your cart" }
    else
      render json: {}, status: :unauthorized
    end
  end

  def create
    cart = current_user.rented_books.where(status: "carted")
    book = Book.find_by(id: params[:book_id])
    duplicate = false
    cart.each do |carted_book|
      p carted_book.book
      if carted_book.book.title == book.title && carted_book.status == "carted"
        duplicate = true
      end
    end
    if duplicate
      render json: { message: "You may only have one copy of a book in your cart at a time" }, status: :unauthorized
    else
      rented_book = RentedBook.new(user_id: current_user.id, book_id: params[:book_id], status: "carted")
      rented_book.save
      render json: rented_book.as_json
    end
  end
end
