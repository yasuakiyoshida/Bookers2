class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]
  
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render 'edit'
      end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user#プロフィールのユーザーと現在ログインしているユーザーが一致しているか比較するメソッド
    @user = User.find(params[:id])#ユーザーIDを取得
    unless @user == current_user#プロフィールのユーザーと現在ログインしているユーザーが異なる場合
      redirect_to user_path(current_user)#自分のプロフィール詳細へリダイレクト
    end
  end
end
