class FavoritesController < ApplicationController

  def create
    @project = Project.find_by(id: params[:project_id])
    favorite = Favorite.find_or_create_by(user:current_user, project: @project)
    redirect_to projects_path
  end

  def show
    if current_user
      @favorites = current_user.favorites
    else
      redirect_to root_path
    end
  end

  def destroy
    Favorite.find_by(project_id: params[:project_id], user_id: params[:user_id]).destroy
    redirect_to projects_path
  end

end
