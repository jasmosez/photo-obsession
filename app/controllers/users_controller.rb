class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end
    
    
    def show
        @comment = Comment.new
        #@current_user = User.find(current_user)
    end

    def create
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
        redirect_to '/login' 
    end

    def follow
        @user = User.find(params[:id])
        User.find(current_user).idols << @user
        redirect_to user_path(@user)
    end
     
    def unfollow
        @user = User.find(params[:id]) 
        Obsession.find_by(fan_id: current_user, idol_id: @user.id).destroy
        redirect_to user_path(@user)
    end

    private
     
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def find_user
        @user = User.find(params[:id])
    end
end
