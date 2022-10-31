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
    params[:categories].each do |category|
      find_category = Category.find_by(name: category)
      book_catagory = BookCategory.new(book_id: book.id, category_id: find_category.id)
      book_catagory.save
    end

    render json: book.as_json
  end

  def update
    book = Book.find_by(id: params[:id])
    book.stock = params[:stock] || book.stock
    book.author_id = params[:author_id] || book.author_id
    book.available = params[:available] || book.available
    book.title = params[:title] || book.title

    book.save

    #update category
    if BookCategory.find_by(book_id: book.id) #if the book has at least one category already assigned
      bc = BookCategory.where(book_id: book.id)
      #loop through each category
      bc.each do |category|
        #delete each category
        category.destroy
      end
    end

    params[:categories].each do |category|
      find_category = Category.find_by(name: category)
      book_category = BookCategory.create(book_id: book.id, category_id: find_category.id)
      book_category.save
    end
    render json: book.as_json
  end

  def destroy
    book = Book.find_by(id: params[:id])

    book.destroy
    BookCategory.where(book_id: book.id).each do |book|
      book.destroy
    end

    render json: { message: "You have removed #{book.title.as_json} from circulation at the Library" }
  end
end
