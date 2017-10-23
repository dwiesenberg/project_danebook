class UsersController < ApplicationController
  
  # before_action :require_login, except: [:new, :create]
    # not needed -- already in application_controller
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update]

  def new
    @user = User.new
    @profile = @user.build_profile
    render :new, layout: "new_user"
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook, #{@user.first_name}!"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash[:warning] = @user.errors.full_messages
      render :new, layout: "new_user"
    end
  end

  def edit
    @profile = current_user.profile
    redirect_to edit_user_profile_path(current_user)
  end

  def update
    puts "update in users_controller"
    if current_user.profile.update(whitelisted_profile_params)
      flash[:success] = "Profile updated!"
      redirect_to current_user.profile
    else
      flash.now[:warning] = "Could not update profile."
      render :edit
    end
  end

  def show
    redirect_to user_profile_path(params[:id])
  end

  def index
    if params[:search]
      user = User.find_by_first_name(params[:search])
      if user.nil?
        flash[:warning] = "Could not find a user by that name"
      else
        redirect_to user_path(user)
      end
    end
    @users = User.all
  end

  private

    def whitelisted_user_params
      params.require(:user).permit(:first_name, 
                                   :last_name, 
                                   :password, 
                                   :password_confirmation, 
                                   :email, 
                                   profile_attributes: 
                                    [:birthday, :sex])
    end
end
