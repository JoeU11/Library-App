class BooksController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]

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
    #Will need to add if books belog to multiple categories
    category = Category.find_by(name: params[:category])
    book_catagory = BookCategory.new(book_id: book.id, category_id: category.id)
    book_catagory.save

    render json: book.as_json
  end

  def update
    book = Book.find_by(id: params[:id])

    Bookbook.stock = params[:stock] || book.stock
    book.author_iBookd = params[:author_id] || book.author_id
    book.availablBooke = params[:available] || book.available
    Bookbook.title = params[:title] || book.title

    Bookbook.save
    render json: book.as_json
  end

  def destroy
    book = Book.find_by(id: params[:id])

    book.destroy

    render json: { message: "You have removed #{book.title.as_json} from circulation at the Library" }
  end
end
