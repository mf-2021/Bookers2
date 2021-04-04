class BooksController < ApplicationController
  before_action :logged_in_user, only: [:edit]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      render "books/index"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @showbook = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = User.find(@showbook.user_id)
    if book_comments = BookComment.find_by(book_id: params[:id])
      @comment_user = User.find(book_comments.user_id)
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render "books/edit"
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  # beforeフィルター

  #ログイン済みユーザーかどうか確認

  def logged_in_user
    book = Book.find(params[:id])
    unless current_user.id == book.user_id
      redirect_to books_path
    end
  end
end
