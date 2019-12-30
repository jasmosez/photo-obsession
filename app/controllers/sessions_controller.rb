class SessionsController < ApplicationController

    def show
        if !session[:user_id]
        redirect_to '/login'
        end
    end
    
    def new

    end 

    def create
        #byebug
        @user = User.find_by(username: params[:username])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        #byebug
        redirect_to '/posts'
    end



    def destroy
        session.delete :username
    end
end 