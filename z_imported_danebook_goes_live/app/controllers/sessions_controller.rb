class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Sign in success"
      redirect_to root_url
    else
      flash.now[:error] = "Sign in failure"
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "Sign out success"
    redirect_to root_path
  end

end
