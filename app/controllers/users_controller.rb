class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end
    
    
    def show
    end

    def create
        byebug
        @user = User.create(user_params)
        redirect_to '/login'
    end

    def edit

    end

    def update
        @user.update(user_params)
        redirect_to user_path(@user)
    end

    def destroy
        @user.destroy
        redirect_to '/login' #!!
    end
     
    private
     
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def find_user
        @user = User.find(params[:id])
    end
end
