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
      @user = User.find_by(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1],
                            provider: "dribbble", projects_url: user_data["projects_url"])

      if @user
        session[:user_id] = @user.id
        redirect_to root_path
      else
        @user = User.new(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1],role: "designer", email: "#{user_data["name"].split[0]}@#{user_data["name"].split[1]}.you",
        password: ENV["PASSWORD"], projects_url: user_data["projects_url"], img: user_data["avatar_url"],
        bio: user_data["bio"], provider: "dribbble", uid:"")

        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path
        else
          @errors.push("Your Dribbble credentials didn't authenticate you.")
          render 'new'
        end
      end
    end
  end

  def github
    user = request.env["omniauth.auth"]["info"]
    @user = User.find_by(email: user["email"])

    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.new(first_name: user["name"].split[0], last_name: user["name"].split[1], role: "developer",
        email: user["email"], password: ENV["PASSWORD"],
        provider: "github", uid: request.env["omniauth.auth"]["uid"],
        projects_url: request.env["omniauth.auth"]["extra"]["raw_info"]["repos_url"],
        bio: request.env["omniauth.auth"]["extra"]["bio"], img: user["image"])

      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        @errors.push("Your Github credentials didn't authenticate you.")
        render 'new'
      end
    end
  end
end
