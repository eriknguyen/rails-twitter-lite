class UsersController < ApplicationController

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

end