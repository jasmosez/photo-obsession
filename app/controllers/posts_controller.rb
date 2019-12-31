class PostsController < ApplicationController

    def index
        @posts = Post.all
        @likes = Like.all
        @comments = Comment.all
        @user = current_user
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
    end

    def create
    end

    def destroy
    end

    private

    def post_params
    end 
end
