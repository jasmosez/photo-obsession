class PostsController < ApplicationController

    def index
        @posts = Post.all
        @comment = Comment.new
        @user = current_user

        # @likes = Like.all
        # @comments = Comment.all
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @user = current_user
    end

    def new
        @post = Post.new
        @user = User.find(current_user)
    end

    def create
        post = Post.create(post_params)
        redirect_to(post_path(post))
    end
    

    def destroy
    end

    private

    def post_params
        params.require(:post).permit(:user_id, :img_url)
    end 
end
