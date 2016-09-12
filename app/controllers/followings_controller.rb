class FollowingsController < ApplicationController
  before_action :set_user
  before_action :set_following, except: [:index]

  def index
  end

  def create

    if request.xhr?
      render :_unfollow, layout: false, locals: {user: @user}
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    @following.destroy
     if request.xhr?
      render :_follow, layout: false, locals: {user: @user}
    else
      redirect_to user_path(@user)
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_following
    @following = Following.find_or_create_by(followed_user_id: @user.id, follower_id: current_user.id)
  end

end
