class LikesController < ApplicationController
  def index
    @likes = extract_likable.likes
  end

  def create
    @likable = extract_likable
    @like = @likable.likes.build(user_id: current_user.id)
    @likable_class = @likable.class.to_s.downcase
    respond_to do |format|
      if @like.save
        format.js
        format.html do
          flash[:success] = "You now like that #{@likable.class}!"
          redirect_back(fallback_location: user_posts_path(current_user))
        end
      else
        flash[:warning] = @like.errors.full_messages
        redirect_back(fallback_location: user_posts_path(current_user))
      end
    end
  end

  def destroy
    @likable = extract_likable
    @like = my_like
    @likable_class = @likable.class.to_s.downcase
    respond_to do |format|
      if my_like.destroy
        format.js
        format.html do
          flash[:success] = "You no longer like that #{extract_likable.class}."
          redirect_back(fallback_location: user_posts_path(current_user))
        end
      else
        flash[:warning] = "Could not unlike that #{extract_likable.class}."
        redirect_back(fallback_location: user_posts_path(current_user))
      end
    end
  end

  private
    def extract_likable
      resource, id = request.path.split('/')[1,2]
      resource.singularize.classify.constantize.find(id)
    end
    def my_like
      likes = extract_likable.likes
      likes.find_by_user_id(current_user.id)
    end
end
