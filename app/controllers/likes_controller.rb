class LikesController < ApplicationController

    def create
        # @current_user = current_user
        @post = params[:id]
        like_params = {user_id: current_user.id, post_id: @post}
        @like = Like.create(like_params)
        
        redirect_to posts_path
 
    end 

    def destroy
        #byebug
        @like = Post.find(params[:id]).like?(current_user)
        @like.destroy
        
        redirect_to posts_path
 
    end
end