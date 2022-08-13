class RentedBooksController < ApplicationController
  # This controller will serve as a 'cart'  as well as a catalogue of currently rented books. Index method is gonna be wild. 
  before_action :authenticate_user
  
  def index
    #show carted books
    books = current_user.rented_books
    render json: books.as_json
  end
end
