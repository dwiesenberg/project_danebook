class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create, :index]
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(safe_user_params)
      flash[:success] = "Successfully updated your profile."
      redirect_to current_user
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  def destroy
    sign_out
  end

  private

  def safe_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender)
  end
end
