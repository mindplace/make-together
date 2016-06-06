class UsersController < ApplicationController
  before_action :set_user

  def index
    @designers = User.where(role: "designer")
    @developers = User.where(role: "developer")
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.create(user_params)
    set_image
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @conversation = Conversation.new
    @review = Review.new
  end

  def admin
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

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :bio, :img)
  end

  def updating_user_params
    user_params.select{|k, v| v != ""}
  end

  def set_image
    @user.img = "https://www.mautic.org/media/images/default_avatar.png"
  end
end
