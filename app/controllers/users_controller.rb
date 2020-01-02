class UsersController < ApplicationController
    before_action :find_current_user, only: [:show, :edit, :update, :destroy]

    def index
        session[:last_view] = "users#index"
        session[:last_view_id] = nil
        @users = User.all 
    end
    
    def new
        @user = User.new
        render :layout => "no_menu"
    end
    
    
    def show
        @user = User.find(params[:id])
        @posts = @user.my_authored_posts
        @comment = Comment.new
        session[:last_view] = "users#show"
        session[:last_view_id] = @user.id
    end

    def create
        #byebug
        user = User.create(user_params)
        if user.valid?
            redirect_to login_path
        else
            flash[:messages] = ["Something went wrong"]
            redirect_to signup_path
        end
    end

    def edit
        # This assignment is to allow us to user the same for as the NEW action
        @user = @current_user
    end

    def update
        @current_user.update(user_params)
        redirect_to redirect_helper
    end

    def destroy
        @current_user.destroy
        redirect_to login_path 
    end

    def follow
        #will add follow/unfollow functionality to user index - will need to redirect_to user index. 
        #come back to this 
        @user = User.find(params[:id])
        current_user.idols << @user
        redirect_to redirect_helper
    end
     
    def unfollow
         #will add follow/unfollow functionality to user index - will need to redirect_to user index. 
        #come back to this 
        @user = User.find(params[:id]) 
        Obsession.find_by(fan_id: current_user, idol_id: @user.id).destroy
        redirect_to redirect_helper
    end

    private
     
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :bio)
    end

    def find_current_user
        @current_user = current_user
    end
end
