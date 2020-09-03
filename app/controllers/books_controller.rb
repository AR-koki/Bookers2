class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit]

	def new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id), notice: "You have creatad book successfully."
		else
			@books = Book.all
			@user = current_user
			render 'books/index'
		end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@books = Book.all
		@book_new = Book.new
		@book_comment = BookComment.new
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

 	def correct_user
	  	@book = current_user.books.find_by(id: params[:id])
	  		unless @book
	  			redirect_to books_path
	  		end
 	end
end
