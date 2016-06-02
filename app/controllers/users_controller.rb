class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @designers = User.where(role: "designer")
    @developers = User.where(role: "developer")
  end

  def show
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
