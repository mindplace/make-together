require "uri"
require "net/http"

class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

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
      redirect_to new_user_registration_url
    else
      user_data = JSON.parse(response)
      @user = User.new(first_name: user_data["name"].split[0], last_name: user_data["name"].split[1],
                       role: "designer", email: "#{user_data["name"].split[0]}@#{user_data["name"].split[1]}.com", password: "unknown",
                       bio: user_data["bio"])

      binding.pry

      if User.find_by(email: @user.email) || @user.save
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Dribbble") if is_navigational_format?
      else
        session["devise.dribbble_data"] = user_data["id"]
        set_flash_message(:notive, :failure) # trying to get this to render...
        redirect_to new_user_registration_url
      end
    end
  end

  def create
    super
    if current_user
      if params[:role] == 'developer' || params[:role] == 'designer'
        current_user.update_attributes(role: params[:role] )
      else
        current_user.update_attributes(role: 'designer')
      end
      current_user.update_attributes(first_name: params[:user][:first_name],  last_name: params[:user][:last_name])
    end
  end

  def failure
    binding.pry
    redirect_to root_path
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
