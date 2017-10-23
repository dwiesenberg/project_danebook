class CommentsController < ApplicationController
  before_action :require_login

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(strong_comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js
        format.html do
          flash[:success] = "Comment published!"
          redirect_back(fallback_location: user_posts_path(@comment.user))
        end
      else
        format.js do
          flash.now[:warning] = "Comment could not be published."
        end
        format.html do
          flash[:warning] = "Comment could not be published."
          redirect_back(fallback_location: user_posts_path(@comment.user))
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    comment_user = @comment.user
    respond_to do |format|
      if comment_user == current_user
        if @comment.destroy
          format.js
          format.html do
            flash[:success] = "Comment deleted."
            redirect_back(fallback_location: user_posts_path(comment_user))
          end
        else
          format.js do
            flash.now[:warning] = @comment.errors.full_messages
            render 'shared/_flash', locals: {flash: flash}
          end
          format.html do
            flash[:warning] = "Comment could not be deleted."
            redirect_back(fallback_location: user_posts_path(comment_user))
          end
        end
      else
        flash[:warning] = "You can only delete your own comments."
        redirect_back(fallback_location: user_posts_path(comment_user))
      end
    end
  end

  private
    def strong_comment_params
      # p params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
