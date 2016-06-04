class FavoritesController < ApplicationController

  def create
   @project = Project.find_by(id: params[:favorite][:project_id])
   favorite = Favorite.find_or_create_by(user:current_user, project: @project)
    redirect_to projects_path
  end

  def show
    if current_user
      @favorites = Favorite.where(user_id: current_user.id)
    else
      render "/_unauthorized"
    end
  end

  def destroy
    Favorite.find_by(id: params[:id]).destroy
    redirect_to projects_path
  end

end