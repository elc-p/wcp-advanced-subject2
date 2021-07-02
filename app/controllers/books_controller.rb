class BooksController < ApplicationController
  before_action :only_user, only: [:edit]

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
    @book_new = Book.new
    @sub_name = "Create Book"
    # binding.pry
  end

  def index
    @book = Book.new
    @books = Book.all
    @sub_name = "Create Book"
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @sub_name = "Update Book"
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def only_user
    @book = Book.find(params[:id])
     unless @book.user == current_user
       redirect_to books_path
     end
  end

end
