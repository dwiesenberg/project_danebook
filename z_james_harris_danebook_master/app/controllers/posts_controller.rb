class PostsController < ApplicationController
  before_action :require_login
  before_action :require_current_user, only: [:create, :update]

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @post = current_user.posts.build
    @posts = @user.posts
  end

  def show

  end

  def create
    @post = current_user.posts.build(strong_post_params)
    respond_to do |format|
      if @post.save
        format.js
        format.html do
          flash[:success] = "Post published!"
          redirect_back(fallback_location: user_posts_path(current_user))
        end
      else
        format.js do
          flash.now[:warning] = @post.errors.full_messages
          render 'shared/_flash', locals: {flash: flash}
        end
        format.html do
          flash[:warning] = @post.errors.full_messages
          @profile = User.find(params[:user_id]).profile
          redirect_back(fallback_location: user_posts_path(current_user))
        end
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      respond_to :js
    else
      flash[:warning] = @post.errors.full_messages
      redirect_to user_posts_path(current_user)
    end
  end

  private
    def strong_post_params
      # p params
      params.require(:post).permit(:body, :user_id)
    end

end
