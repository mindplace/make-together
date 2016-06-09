class FollowingsController < ApplicationController

  def index
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.find_by(id: params[:id])
    @following = Following.find_or_create_by(followed_user_id: @user.id, follower_id: current_user.id)
    if request.xhr?
      render :_unfollow, layout: false, locals: {user: @user}
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @following = Following.find_or_create_by(followed_user_id: @user.id, follower_id: current_user.id).destroy
     if request.xhr?
      render :_follow, layout: false, locals: {user: @user}
    else
      redirect_to user_path(@user)
    end
  end

end
