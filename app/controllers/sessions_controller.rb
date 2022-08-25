class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
    render 'login'
  end

  def create
    username = user_params[:username]
    password = user_params[:password]

    @user = User.find_by(username: username)

    if @user and @user.authenticate(password)
      flash[:notice] = 'Welcome!'
      session[:user_id] = @user.id
      redirect_to(root_path)
    else
      flash.now[:error] = "Username or password is incorrect"
      render 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(login_path)
  end

  private 

  def user_params 
    params.permit(:username, :password)
  end

  def logged_in_redirect 
    redirect_to root_path if logged_in?
  end
end
