class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end
  
  def show
    @books = Book.new
    # @bookにするとform_withがcreateではなくupdateに飛ぶ
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
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
  
  def ensure_correct_user#投稿したユーザーと現在ログインしているユーザーを比較するメソッド
    @book = Book.find(params[:id])#投稿を取得
    unless @book.user == current_user#投稿したユーザーが現在ログインしているユーザーではない場合
      redirect_to books_path#投稿一覧画面にリダイレクト
    end
  end
end