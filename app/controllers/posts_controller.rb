class PostsController < ApplicationController

    def index
        @posts = Post.all
        @user = current_user
        @comment = Comment.new
        # @likes = Like.all
        # @comments = Comment.all
    end

    def show
        @post = Post.find(params[:id])
        @user = current_user
        @comment = Comment.new
    end

    def new
        @post = Post.new
        @user = User.find(current_user)
    end

    def create
        byebug
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