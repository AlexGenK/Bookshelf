class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.order(:title)
  end

  def new
    @book = Category.default_category.books.new
  end

  def create
    @book = Category.default_category.books.new(book_params)
    if @book.save
      redirect_to books_path
    else
      flash[:alert] = 'Unable create the book'
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  def edit
  end

  def update
    if @book.update(book_params)
        redirect_to books_path, notice: 'Book was successfully updated.'
      else
        flash[:alert] = 'Unable update the book'
        render :edit
      end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :cover, :category_id)
  end
end
