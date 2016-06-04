class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user

  def index
    @designers = User.where(role: "designer")
    @developers = User.where(role: "developer")
  end

  def show
  end

  def edit
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

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :bio)
  end

end
