class SessionsController < ApplicationController

    def show
       
        if !session[:user_id]
            redirect_to login_path
        end
        
        @current_user = current_user
        @posts = current_user.my_idols_posts
        @comment = Comment.new
        session[:last_view] = "sessions#show"
        session[:last_view_id] = nil
                
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