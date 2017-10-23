class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to root_path # ie users#new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome back, #{@user.first_name}."
      redirect_to @user
      # same as "redirect_to user_path(@user)"
    else
      flash.now[:error] = "Sign-in unsuccessful."
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed out."
    redirect_to root_path
  end
end
