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
    unless logged_in?
      render "/_unauthorized"
    end
  end

  def update
    if current_user == @user
      if params[:role] == 'developer' || params[:role] == 'designer'
        current_user.update_attributes(role: params[:role])
        if current_user.update_attributes(user_params)
          redirect_to user_path(current_user)
        else
          render :edit
        end
      else
        render :edit
      end
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
