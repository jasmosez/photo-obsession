class PostsController < ApplicationController

    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        # Establish default for sort_choice
        default = "Recent"
        

        # store sort_choice in session, if it exists
        # store default in session, if no session[sort_choice] exists
        # otherwise, just use what's already in session
        if params[:sort_choice] 
           session[:sort_choice] = params[:sort_choice]
        else
            if !session[:sort_choice]
                session[:sort_choice] = default
            end
        end
        
        # sort @posts and set preset based on sort_choice
        @posts = Post.sort_index(session[:sort_choice])
        @preset = session[:sort_choice]
    
        # pass other necessary instance variables to the view
        @sort_options = Post.sort_options    
        @comment = Comment.new
        @current_user = current_user

        # set last_view
        session[:last_view] = "posts#index"
        session[:last_view_id] = nil
        
    end

    def show
        @comment = Comment.new
        @user = User.find(@post.user.id)
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
        redirect_to post_path(post)
    end

    def edit
        @current_user = current_user
    end

    def update
        @post.update(post_params)
        redirect_to post_path(@post)
    end
    
    def destroy
        @post.destroy
        redirect_to user_path(current_user)
    end

    private

    def post_params
        params.require(:post).permit(:user_id, :img_url, :caption)
    end 

    def find_post
        @post = Post.find(params[:id])
    end
end
