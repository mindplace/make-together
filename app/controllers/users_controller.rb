class UsersController < ApplicationController
  before_action :set_user

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def index
    @designers = User.where(role: "designer")
    @developers = User.where(role: "developer")
  end

  def show
  end

  def edit
    if !logged_in? || @user != current_user
      redirect_to root_path
    end
  end

  def update
    @user.update_attributes(updating_user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :bio)
  end

  def updating_user_params
    user_params.select{|k, v| v != ""}
  end
end
