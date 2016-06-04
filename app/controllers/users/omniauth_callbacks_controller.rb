class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end
  # def passthru
  #   binding.pry
  #   super
  # end


  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    user = request.env["omniauth.auth"]["info"]

    unless User.find_by(email: user["email"], first_name: user["name"].split[0], last_name: user["name"].split[1])
      @user.update_attributes(first_name: user["name"].split[0], last_name: user["name"].split[1], role: "developer")
    end

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      # set_flash_message(:notive, :failure) # trying to get this to render...
      redirect_to new_user_registration_url
    end
  end

  def failure
    # binding.pry
    redirect_to root_path
  end
end
