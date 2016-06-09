class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def index
  end

  def creators
  end

  private

  def record_not_found
    redirect_to root_path
  end
end
