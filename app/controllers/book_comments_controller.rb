class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    # redirect_to book_path(book)
    @showbook = Book.find(params[:book_id])
    @book_comment = BookComment.new
    @user = User.find(@showbook.user_id)
    @book = Book.new
    if book_comments = BookComment.find_by(book_id: params[:book_id])
      @comment_user = User.find(book_comments.user_id)
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
    @showbook = Book.find(params[:book_id])
    @book_comment = BookComment.new
    @user = User.find(@showbook.user_id)
    @book = Book.new
    if book_comments = BookComment.find_by(book_id: params[:book_id])
      @comment_user = User.find(book_comments.user_id)
    end
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
