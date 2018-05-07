class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log the @user in and redirect to @user's show page
      log_in @user
      puts params[:session][:remember_me]
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user #note again: = redirect_to @user_url(@user)
    else
      # create an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
