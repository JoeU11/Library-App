class RentalsController < ApplicationController
  before_action :authenticate_user
  
  def create
    carted_books = current_user.rented_books.where(status: "carted")
    rented_books = current_user.rented_books.where(status: "rented")
    overdue_books = current_user.rented_books.where(status: "overdue")
    if carted_books.count == 0
      render json: {message: "There is nothing in your cart"}, status: :unauthorized
    elsif carted_books.count + rented_books.count + overdue_books.count <= 3 
      all_available = true
      already_rented = false
      carted_books.each do |carted_book|
        if carted_book.book.available == 0
          all_available = false
        end
        rented_books.each do |rented_book|
          if carted_book.book_id == rented_book.book_id
            already_rented = true
          end
        end
      end
      if all_available && !already_rented
        rental = Rental.new(user_id: current_user.id)
        rental.save
        carted_books.each do |carted_book|
          carted_book.rental_id = rental.id
          carted_book.book.available -= 1 
          carted_book.status = "rented"
          carted_book.due_date = rental.created_at.weeks_since(2)
          carted_book.save
          carted_book.book.save
        end
        render json: rental.as_json
      elsif !all_available && !already_rented
        render json: {message: "Sorry, one of the books you have selected has no currently available copies"}, status: :unauthorized
      else
        render json: {message: "You may only rent one copy of a book at a time"}, status: :unauthorized
      end
    else
      render json: {message:  "You may only rent up to three books at a time"}, status: :unauthorized
    end
  end
end
