class UsersController < ApplicationController
	before_action :correct_user, only: [:edit]

  def index
  	@users = User.all
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
	if @book.save
		redirect_to book_path(@book.id), notice: "You have creatad book successfully."
	else
		@books = Book.all
		render 'books/index'
	end
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "You have updated user successfully."
 	else
  		render 'users/edit'
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
  	user = User.find(params[:id])
  	redirect_to users_path if current_user != user
  end
end
