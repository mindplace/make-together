class OmniauthController < ApplicationController
  def dribbble_oauth_request
    # redirect to https://dribbble.com/oauth/authorize
    dribbble = "https://dribbble.com/oauth/authorize"
    params = {"client_id" => ENV["DRIBBBLE_CLIENT_ID"]}
    redirect_to "#{dribbble}?#{params.to_query}"
  end

  def passthru
    # get back the code
    params = {"client_id" => ENV["DRIBBBLE_CLIENT_ID"],
              "client_secret" => ENV["DRIBBBLE_CLIENT_SECRET"],
              "code" => request.env["QUERY_STRING"][5..-1],
              'button1' => 'Submit'
              }

    # use code to request access token
    uri = URI.parse('https://dribbble.com/oauth/token')
    request = Net::HTTP.post_form(uri, params)
    token = JSON.parse(request.response.body)["access_token"]

    # use access token to get access to the API
    params = {"access_token" => token}
    uri = URI.parse('https://api.dribbble.com/v1/user')
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get(uri)

    if response.blank?
      redirect_to new_user_url
    else
      user_data = JSON.parse(response)

      # this is a risk because of potential users sharing names
      # can't figure out how to pass params to and back from Dribbble
      @neither_user = User.find_by(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1], github: nil, dribbble: nil)

      @both_user = User.find_by(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1], dribbble: "dribbble", dribbble_url: user_data["html_url"], github: "github")
      @github_user = User.find_by(first_name: user_data["name"].split[0],
                        last_name: user_data["name"].split[1], github: "github")
      @dribbble_user = User.find_by(dribbble_uid: user_data["id"])

      if @both_user || @dribbble_user
        if @dribbble_user
          session[:user_id] = @dribbble_user.id
        else
          session[:user_id] = @both_user.id
        end
        redirect_to root_path

      elsif @github_user
        @github_user.update_attributes(dribbble: "dribbble", dribbble_uid: user_data["id"], dribbble_url: user_data["html_url"])
        redirect_to user_path(current_user)
      else
        @user = User.new(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1],role: "designer", dribbble_url: user_data["html_url"], img: user_data["avatar_url"],bio: user_data["bio"], dribbble: "dribbble", dribbble_uid: user_data["id"])
        render 'choose_email_password'
      end
    end
  end

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
      redirect_to user_path(current_user)

    elsif @dribbble_user || @neither_user
      if @dribbble_user
        @dribbble_user.update_attributes(github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"], github: "github", github_uid: request.env["omniauth.auth"]["uid"], img: user["image"])
        session[:user_id] = @dribbble_user.id
        redirect_to user_path(current_user)
      else
        @neither_user.update_attributes(github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"], github: "github", github_uid: request.env["omniauth.auth"]["uid"], img: user["image"])
        session[:user_id] = @neither_user.id
        redirect_to user_path(current_user)
      end

    else
      @user = User.new(first_name: user["name"].split[0], last_name: user["name"].split[1], role: "developer", email: user["email"], github: "github", github_uid: request.env["omniauth.auth"]["uid"],
        github_url: request.env["omniauth.auth"]["info"]["urls"]["GitHub"],
        bio: request.env["omniauth.auth"]["extra"]["bio"], img: user["image"])
      render 'choose_email_password'
    end
  end

  def password
    @user = User.new(user_params)
    @user.role = "developer" if @user.role != "designer" || @user.role != "developer"
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
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
