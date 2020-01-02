class SessionsController < ApplicationController

    skip_before_action :require_login, :set_nav_variables, only: [:show, :new, :create, :destroy]

    def show
        if !session[:user_id]
            # puts "HELLOOOOOOOO"
            redirect_to login_path
        else 
            @current_user = current_user
            @posts = current_user.my_idols_posts
            @comment = Comment.new
            session[:last_view] = "sessions#show"
            session[:last_view_id] = nil
            
        set_nav_variables
        end
        
    end
    
    def new
        render :layout => "no_menu"
    end 

    def create
        user = User.find_by(username: params[:username])
        authenticated = user.try(:authenticate, params[:password])
        if authenticated
            session[:user_id] = user.id
            redirect_to dashboard_path
        else
            flash[:messages] = ["No Account with that Username and Password"]
            redirect_to login_path
        end

    end


    def destroy
        session.delete :user_id
        redirect_to login_path
    end
end 