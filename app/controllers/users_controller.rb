class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @book = Book.new
        @books = Book.where(user_id: @user.id)
    end

    def index
        @user = current_user
        @users = User.all
        @book = Book.new
        @books = Book.all
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice]="You have create user successfully."
            redirect_to  user_path(current_user.id)
        else
            render "users/sign_up"
        end
    end

    def edit
        @user = User.find(params[:id])
        if @user == current_user
            render :edit
        else
            redirect_to  user_path(current_user)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice]="You have updated user successfully."
            redirect_to user_path(current_user)
        else
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
