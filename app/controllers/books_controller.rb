class BooksController < ApplicationController
  def index
    if params[:category]
      category = Category.find_by(name: params[:category])
      books = category.books
    else
      books = Book.all
    end
    render json: books
  end

  def show
    book = Book.find_by(id: params[:id])
    render json: book.as_json
  end
end
