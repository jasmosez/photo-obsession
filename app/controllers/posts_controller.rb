class PostsController < ApplicationController

    def index
        @posts = Post.all
        @comment = Comment.new
        @current_user = current_user
        session[:last_view] = "posts#index"
        session[:last_view_id] = nil

        # @likes = Like.all
        # @comments = Comment.all
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @current_user = current_user
        session[:last_view] = "posts#show"
        session[:last_view_id] = @post.id
    end

    def new
        @post = Post.new
        @current_user = current_user
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
