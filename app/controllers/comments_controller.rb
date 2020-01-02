class CommentsController < ApplicationController

  before_action :find_comment, except: :create
  
  def create
    Comment.create(comment_params)
    redirect_to redirect_helper
  end

  def edit
    @post = Post.find(@comment.post_id)
    @current_user = current_user
  end

  def update
    @comment.update(comment_params)
    redirect_to redirect_helper
  end

  def destroy
    @comment.destroy
    redirect_to redirect_helper
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
