class SessionsController < ApplicationController

  def new
    if logged_in?
      render :welcome
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(login_email)
    if @user && @user.authenticate(login_password[:password])
      session[:user_id] = @user.id
      render '/users/welcome'
    else
      if @user
        @user.errors[:password].push("incorrect")
      else
        @user = User.new
        @user.errors[:username].push("not found")
      end
      render 'new'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def login_email
    params.require(:login).permit(:email)
  end

  def login_password
    params.require(:login).permit(:password)
  end

end
