class UsersController < ApplicationController
  before_action :set_user

  def index
    @designers = User.where(role: "designer")
    @developers = User.where(role: "developer")
  end

  def new
    if logged_in?
      render :welcome
    else
      @user = User.new
    end
  end

  def create
    @user = User.create(user_params)
    set_image
    if @user.save
      session[:user_id] = @user.id
      render :welcome
    else
      render 'new'
    end
  end

  def add_dribbble_info
    if params[:success] != "true"
      # data has failed to return for some reason
      # write to the console to log this issue
      write_to_log("Dribbble call failed. Info: '#{params[:message]}'")

      # build message showing failure
      flash[:message] = "Dribbble authentication was unsuccessful."
      if current_user # send back to their user page
        @user = current_user
        render :show
      else # send back to login page
        @user = User.new
        render :new
      end
      return
    end

    # if there's been data found, create or append user info
    data = params[:user_data]
    if current_user # append to user model
      @user = current_user
      @user.update_attributes(img: data[:avatar_url], bio: data[:bio], dribbble: true, dribbble_uid: data[:id], dribbble_url: data[:html_url], role: "designer", first_name: data[:name].split[0], last_name: data[:name].split[1])

      if @user.save
        render :show
      end

    else # user is not signed in, or user is not registered
      @user = User.find_by(dribbble_uid: data[:id])
      if @user
        session[:user_id] = @user.id
        render 'show'
      else
        @user = User.new(img: data[:avatar_url], bio: data[:bio], dribbble: true, dribbble_uid: data[:id], dribbble_url: data[:projects_url], role: "designer", first_name: data[:name].split[0], last_name: data[:name].split[1])
        render 'omniauth/choose_email_password'
      end
    end
  end

  def show
    if @user.nil?
      redirect_to root_path
    else
      @conversation = Conversation.new
      @review = Review.new
    end
  end

  def admin
    @reports = Report.all
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

  def dribbble_user
    @dribbble_user = params[:user_data]
    binding.pry # TODO: check, is this a hash?
  end

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
