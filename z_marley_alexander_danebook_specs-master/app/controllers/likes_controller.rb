class LikesController < ApplicationController

	def create
		@like = likable_type.likes.build(user_id: current_user.id)
		if @like.save
			redirect_to request.referer
		else
			flash[:error] = "You have incorrectly liked this"
			redirect_to request.referer
		end
	end

	def destroy
	end

	private

  def likable_type
  	likable_class.find(params[parent_id])
  end

  def likable_class
  	params[:likable].singularize.classify.constantize
  end

  def parent_id
    "#{params[:likable].to_s}_id".downcase.to_sym
  end

end
