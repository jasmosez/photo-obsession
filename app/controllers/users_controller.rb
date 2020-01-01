class UsersController < ApplicationController
    before_action :find_current_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end
    
    
    def show
        @user = User.find(params[:id])
        @posts = @user.my_authored_posts
        @comment = Comment.new
    end

    def create
        User.create(user_params)
        redirect_to '/login'
    end

    def edit
        # This assignment is to allow us to user the same for as the NEW action
        @user = @current_user
    end

    def update
        @current_user.update(user_params)
        redirect_to user_path(@current_user)
    end

    def destroy
        @current_user.destroy
        redirect_to '/login' #!! 
    end

    def follow
        @user = User.find(params[:id])
        current_user.idols << @user
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

    def find_current_user
        @current_user = current_user
    end
end
