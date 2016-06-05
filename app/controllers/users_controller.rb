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
    avatars = ["http://s33.postimg.org/bxh2ye0qn/av1.png", "http://s33.postimg.org/i28lbpsu7/av2.png", "http://s33.postimg.org/t5s7hbe4f/av3.png", "http://s33.postimg.org/wvn8wh0lb/av4.png", "http://s33.postimg.org/5qaabyudb/av5.png", "http://s33.postimg.org/usctot0sf/av6.png", "http://s33.postimg.org/yen8f6wjj/av7.png", "http://s33.postimg.org/nvn8q0tvj/av8.png", "http://s33.postimg.org/66vhyei4f/av9.png", "http://s33.postimg.org/8ph6z33un/av10.png", "http://s33.postimg.org/jdkxxxdtr/av11.png", "http://s33.postimg.org/b9ctt6ren/av12.png" ]
    @user.img = avatars.sample
  end
end
