class SessionsController < ApplicationController

    def show
       
        if !session[:user_id]
            redirect_to '/login'
        end
        
        @current_user = current_user
        @posts = current_user.my_idols_posts
        @comment = Comment.new
        session[:last_view] = "sessions#show"
        session[:last_view_id] = nil
                
    end
    
    def new
    end 

    def create
        user = User.find_by(username: params[:username])
        authenticated = user.try(:authenticate, params[:password])
        return head(:forbidden) unless authenticated

        # return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_path
    end



    def destroy
        session.delete :username
    end
end 