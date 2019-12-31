class LikesController < ApplicationController

    def create
        @user = current_user
        @post = params[:id]
        likes = {user_id: @user, post_id: @post}
        @like = Like.create(likes)
        
        redirect_to posts_path
 
    end 

    def destroy
        #byebug
        @like = Post.find(params[:id]).like?(current_user)
        @like.destroy
        
        redirect_to posts_path
 
    end
end