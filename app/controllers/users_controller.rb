class UsersController < ApplicationController

  # Before filter: by default apply to every actions in a controller
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # handle successful case
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user   #equivalent to `redirect_to user_url(@user)`
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        # handle successful update
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # params.permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #confirms a correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end