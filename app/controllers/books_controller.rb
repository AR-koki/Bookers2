class BooksController < ApplicationController

	def top
	end

	def new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.user_id), notice: "You have creatad book successfully."
		else
			@books = Book.all
			render 'books/index'
		end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = User.new
	end

	def show
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
	      redirect_to book_path(@book), notice: "Book was successfully created."
	    else
	      render 'books/edit'
	    end
	end

	def destroy
		book = Book.find(params[:id])
	    book.destroy
	    redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
