class SessionsController < ApplicationController

    def show
        if !session[:user_id]
            redirect_to '/login'
        end
        
        @user = User.find(current_user)
        @posts = @user.my_idols_posts
        @comment = Comment.new
    end
    
    def new
    end 

    def create
        @user = User.find_by(username: params[:username])
        authenticated = @user.try(:authenticate, params[:password])
        return head(:forbidden) unless authenticated

        # return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to dashboard_path
    end



    def destroy
        session.delete :username
    end
end 