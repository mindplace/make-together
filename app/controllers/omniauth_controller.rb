class OmniauthController < ApplicationController
  def github
    user = request.env["omniauth.auth"]["info"]

    @neither_user = User.find_by(id: request.env["omniauth.params"]["user_id"], github: nil, dribbble: nil)
    @both_user = User.find_by(dribbble: "dribbble", github: "github", github_uid: request.env["omniauth.auth"]["uid"])
    @github_user = User.find_by(github_uid: request.env["omniauth.auth"]["uid"])
    @dribbble_user = User.find_by(first_name: user["name"].split[0], last_name: user["name"].split[1], dribbble: "dribbble")

    if @both_user || @github_user
      if @github_user
        session[:user_id] = @github_user.id
      else
        session[:user_id] = @both_user.id
      end
      render '/application/_modal'

    elsif @dribbble_user || @neither_user
      if @dribbble_user
        @dribbble_user.update_attributes(github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"], github: "github", github_uid: request.env["omniauth.auth"]["uid"], img: user["image"])
        session[:user_id] = @dribbble_user.id
        render '/application/_modal'
      else
        @neither_user.update_attributes(github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"], github: "github", github_uid: request.env["omniauth.auth"]["uid"], img: user["image"])
        session[:user_id] = @neither_user.id
        render '/application/_modal'
      end

    else
      @user = User.find_by(email: user["email"])
      if @user.nil?
        @user = User.new(first_name: user["name"].split[0], last_name: user["name"].split[1], role: "developer", email: user["email"], github: "github", github_uid: request.env["omniauth.auth"]["uid"],
          github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"],
          bio: request.env["omniauth.auth"]["extra"]["bio"], img: user["image"])
      else
        @user.update_attributes(first_name: user["name"].split[0], last_name: user["name"].split[1], github: "github", github_uid: request.env["omniauth.auth"]["uid"],
          github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"],
          bio: request.env["omniauth.auth"]["extra"]["bio"], img: user["image"])
      end
      render 'choose_email_password'
    end
  end

  def password
    @user = User.new(user_params)
    @user.role = "developer" if @user.role != "designer" || @user.role != "developer"
    if @user.save
      session[:user_id] = @user.id
      render '/application/_modal'
    else
      render 'choose_email_password'
    end
  end

  private

  def user_params
    new_params = params.require(:user).permit(:email, :password)
    if params[:github]
      new_params.merge(params.permit(:role, :github_uid, :github, :bio, :img, :last_name, :first_name, :github_url))
    else
      new_params.merge(params.permit(:role, :dribbble_uid, :dribbble, :bio, :img, :last_name, :first_name, :dribbble_url))
    end
  end
end
