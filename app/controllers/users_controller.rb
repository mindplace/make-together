class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: {:index, :new, :create}

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

end
