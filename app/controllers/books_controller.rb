class BooksController < ApplicationController
  before_action :authenticate_admin, only: [:create]

  def index
    if params[:category]
      category = Category.find_by(name: params[:category])
      @books = category.books
    else
      @books = Book.all
    end
    render template: "books/index"
  end

  def show
    @book = Book.find_by(id: params[:id])
    render template: "books/show"
  end

  def create
    book = Book.new(
      title: params[:title],
      stock: params[:stock],
      available: params[:available],
      title: params[:title],
      title: params[:title],
      author_id: params[:author_id],
    )
    book.save
    render json: book.as_json
  end
end
